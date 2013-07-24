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
      exist_options    = {
        error_404_hash:  wp_target.error_404_hash,
        homepage_hash:   wp_target.homepage_hash,
        exclude_content: options[:exclude_content] ? %r{#{options[:exclude_content]}} : nil
      }

      # If we only want the vulnerable ones, the passive detection is ignored
      # Otherwise, a passive detection is performed, and results will be merged
      results = options[:only_vulnerable] ? new : passive_detection(wp_target, options)

      targets.each do |target_item|
        request = browser.forge_request(target_item.url, request_params)

        request.on_complete do |response|
          progress_bar.progress += 1 if options[:show_progression]

          if target_item.exists?(exist_options, response)
            if !results.include?(target_item)
              if !options[:only_vulnerable] || options[:only_vulnerable] && target_item.vulnerable?
                results << target_item
              end
            end
          end
        end

        hydra.queue(request)
      end

      hydra.run
      results.sort!
      results # can't just return results.sort because the #sort returns an array, and we want a WpItems
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
      results  = new(wp_target)
      body     = Browser.get(wp_target.url).body
      names    = body.scan(passive_detection_pattern(wp_target))

      names.flatten.uniq.each { |name| results.add(name) }

      results.sort!
      results
    end

    protected

    # @param [ WpTarget ] wp_target
    #
    # @return [ Regex ]
    def passive_detection_pattern(wp_target)
      type   = self.to_s.gsub(/Wp/, '').downcase
      regex1 = %r{(?:[^=:]+)\s?(?:=|:)\s?(?:"|')[^"']+\\?/}
      regex2 = %r{\\?/}
      regex3 = %r{\\?/([^/\\"']+)\\?(?:/|"|')}

      /#{regex1}#{Regexp.escape(wp_target.wp_content_dir)}#{regex2}#{Regexp.escape(type)}#{regex3}/i
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

      targets = vulnerable_targets_items(wp_target, item_class, vulns_file)

      unless options[:only_vulnerable]
        unless options[:file]
          raise 'A file must be supplied'
        end

        targets += targets_items_from_file(options[:file], wp_target, item_class, vulns_file)
      end

      targets.uniq! { |t| t.name }
      targets.sort_by { rand }
    end

    # @param [ WpTarget ] wp_target
    # @param [ Class ] item_class
    # @param [ String ] vulns_file
    #
    # @return [ Array<WpItem> ]
    def vulnerable_targets_items(wp_target, item_class, vulns_file)
      targets = []
      xml     = xml(vulns_file)

      xml.xpath(item_xpath).each do |node|
        targets << create_item(
          item_class,
          node.attribute('name').text,
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
