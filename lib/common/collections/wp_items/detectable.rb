# encoding: UTF-8

class WpItems < Array
  module Detectable

    attr_reader :vulns_file, :item_xpath

    # @param [ WpTarget ] wp_target
    # @param [ Hash ] options
    # @option options [ Boolean ] :show_progression  Whether or not output the progress bar
    # @option options [ Boolean ] :only_vulnerable   Only check for vulnerable items
    # @option options [ String ]  :exclude_content
    #
    # @return [ WpItems ]
    def aggressive_detection(wp_target, options = {})
      browser          = Browser.instance
      hydra            = browser.hydra
      targets          = targets_items(wp_target, options)
      progress_bar     = progress_bar(targets.size, options)
      queue_count      = 0
      exist_options    = {
        error_404_hash:  wp_target.error_404_hash,
        homepage_hash:   wp_target.homepage_hash,
        exclude_content: options[:exclude_content] ? %r{#{options[:exclude_content]}} : nil
      }
      results          = passive_detection(wp_target, options)

      targets.each do |target_item|
        request = browser.forge_request(target_item.url, request_params)

        request.on_complete do |response|
          progress_bar.progress += 1 if options[:show_progression]

          if target_item.exists?(exist_options, response)
            results << target_item unless results.include?(target_item)
          end
        end

        hydra.queue(request)
        queue_count += 1

        if queue_count >= browser.max_threads
          hydra.run
          queue_count = 0
          puts "Sent #{browser.max_threads} requests ..." if options[:verbose]
        end
      end

      # run the remaining requests
      hydra.run

      results.select!(&:vulnerable?) if options[:type] == :vulnerable
      results.sort!

      results  # can't just return results.sort as it would return an array, and we want a WpItems
    end

    # @param [ Integer ] targets_size
    # @param [ Hash ] options
    #
    # @return [ ProgressBar ]
    # :nocov:
    def progress_bar(targets_size, options)
      if options[:show_progression]
        ProgressBar.create(
          format: '%t %a <%B> (%c / %C) %P%% %e',
          title: '  ', # Used to craete a left margin
          total: targets_size
        )
      end
    end
    # :nocov:

    # @param [ WpTarget ] wp_target
    # @param [ Hash ] options
    #
    # @return [ WpItems ]
    def passive_detection(wp_target, options = {})
      results = new(wp_target)
      # improves speed
      body    = remove_base64_images_from_html(Browser.get(wp_target.url).body)
      page    = Nokogiri::HTML(body)
      names   = []

      page.css('link,script,style').each do |tag|
        %w(href src).each do |attribute|
          attr_value = tag.attribute(attribute).to_s
          next unless attr_value

          names << Regexp.last_match[1] if attr_value.match(attribute_pattern(wp_target))
        end

        next unless tag.name == 'script' || tag.name == 'style'

        code = tag.text.to_s
        next if code.empty?

        if ! code.valid_encoding?
          code = code.encode('UTF-16be', :invalid => :replace, :replace => '?').encode('UTF-8')
        end

        code.scan(code_pattern(wp_target)).flatten.uniq.each do |item_name|
          names << item_name
        end
      end

      names.uniq.each { |name| results.add(name) }

      results.sort!
      results
    end

    protected

    # @param [ WpTarget ] wp_target
    #
    # @return [ Regex ]
    def item_pattern(wp_target)
      type = to_s.gsub(/Wp/, '').downcase
      wp_content_dir = wp_target.wp_content_dir
      wp_content_url = wp_target.uri.merge(wp_content_dir).to_s

      url = wp_content_url.gsub(%r{\A(?:http|https)://}, '(?:https?:)?//').gsub('/', '\\\\\?\/')
      content_dir = %r{(?:#{url}|\\?\/\\?\/?#{wp_content_dir})}i

      %r{#{content_dir}\\?/#{type}\\?/}
    end

    # @param [ WpTarget ] wp_target
    #
    # @return [ Regex ]
    def attribute_pattern(wp_target)
      /\A#{item_pattern(wp_target)}([^\/]+)/i
    end

    # @param [ WpTarget ] wp_target
    #
    # @return [ Regex ]
    def code_pattern(wp_target)
      /["'\(]#{item_pattern(wp_target)}([^\\\/\)"']+)/i
    end

    # The default request parameters
    #
    # @return [ Hash ]
    def request_params; { cache_ttl: 0, followlocation: true } end

    # @param [ WpTarget ] wp_target
    # @param [ options ] options
    # @option options [ Boolean ] :only_vulnerable
    # @option options [ String ]  :file The path to the file containing the targets
    #
    # @return [ Array<WpItem> ]
    def targets_items(wp_target, options = {})
      item_class = self.item_class
      vulns_file = self.vulns_file

      targets = target_items_from_type(wp_target, item_class, vulns_file, options[:type])

      targets.uniq! { |t| t.name }
      targets.sort_by { rand }
    end

    # @param [ WpTarget ] wp_target
    # @param [ Class ] item_class
    # @param [ String ] vulns_file
    #
    # @return [ Array<WpItem> ]
    def target_items_from_type(wp_target, item_class, vulns_file, type)
      targets = []
      json    = json(vulns_file)

      case type
      when :vulnerable
        items = json.select { |item| !json[item]['vulnerabilities'].empty? }.keys
      when :popular
        items = json.select { |item| json[item]['popular'] == true }.keys
      when :all
        items = json.keys
      else
        raise "Unknown type #{type}"
      end

      items.each do |item|
        targets << create_item(
          item_class,
          item,
          wp_target,
          vulns_file
        )
      end

      targets
    end

    # @param [ Class ] klass
    # @param [ String ] name
    # @param [ WpTarget ] wp_target
    # @option [ String ] vulns_file
    #
    # @return [ WpItem ]
    def create_item(klass, name, wp_target, vulns_file = nil)
      klass.new(
        wp_target.uri,
        name:           name,
        vulns_file:     vulns_file,
        wp_content_dir: wp_target.wp_content_dir,
        wp_plugins_dir: wp_target.wp_plugins_dir
      )
    end

    # @param [ String ] file
    # @param [ WpTarget ] wp_target
    # @param [ Class ] item_class
    # @param [ String ] vulns_file
    #
    # @return [ Array<WpItem> ]
    def targets_items_from_file(file, wp_target, item_class, vulns_file)
      targets = []

      File.open(file, 'r') do |f|
        f.readlines.collect do |item_name|
          targets << create_item(
            item_class,
            item_name.strip,
            wp_target,
            vulns_file
          )
        end
      end

      targets
    end

    # @return [ Class ]
    def item_class
      Object.const_get(self.to_s.gsub(/.$/, ''))
    end
  end
end
