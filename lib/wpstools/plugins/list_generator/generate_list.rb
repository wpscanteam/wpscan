# encoding: UTF-8

# This tool generates a list to use for plugin and theme enumeration
class GenerateList

  attr_accessor :verbose

  # type = themes | plugins
  def initialize(type, verbose)
    if type =~ /plugins/i
      @type           = 'plugin'
      @svn_url        = 'http://plugins.svn.wordpress.org/'
      @popular_url    = 'http://wordpress.org/plugins/browse/popular/'
      @popular_regex  = %r{<h3><a href="http://wordpress.org/plugins/([^/]+)/">.+</a></h3>}i
    elsif type =~ /themes/i
      @type           = 'theme'
      @svn_url        = 'http://themes.svn.wordpress.org/'
      @popular_url    = 'http://wordpress.org/themes/browse/popular/'
      @popular_regex  = %r{<h3><a href="http://wordpress.org/themes/([^/]+)">.+</a></h3>}i
    else
      raise "Type #{type} not defined"
    end
    @verbose  = verbose
    @browser  = Browser.instance(request_timeout: 20000, connect_timeout: 20000, max_threads: 1, cache_ttl: 0)
  end

  def set_file_name(type)
    case @type
    when 'plugin'
      case type
      when :full
        @file_name = PLUGINS_FULL_FILE
      when :popular
        @file_name = PLUGINS_FILE
      else
        raise 'Unknown type'
      end
    when 'theme'
      case type
      when :full
        @file_name = THEMES_FULL_FILE
      when :popular
        @file_name = THEMES_FILE
      else
        raise 'Unknown type'
      end
      else
        raise "Unknown type #@type"
    end
  end

  def generate_full_list
    set_file_name(:full)
    items = SvnParser.new(@svn_url).parse
    save items
  end

  def generate_popular_list(pages)
    set_file_name(:popular)
    items = get_popular_items(pages)
    save items
  end

  # Send a HTTP request to the WordPress most popular theme or plugin webpage
  # parse the response for the names.
  def get_popular_items(pages)
    found_items = []
    page_count  = 1
    retries     = 0

    (1...(pages.to_i + 1)).each do |page|
      # First page has another URL
      url = (page == 1) ? @popular_url : @popular_url + 'page/' + page.to_s + '/'
      puts "[+] Parsing page #{page_count}" if @verbose
      code = 0

      while code != 200 && retries <= 3
        puts red("[!] Retrying request for page #{page} (Code: #{code})") unless code == 0

        request  = @browser.forge_request(url)
        response = request.run
        code     = response.code

        sleep(5) unless code == 200
        retries += 1
      end

      page_count += 1
      found = 0

      response.body.scan(@popular_regex).each do |item|
        found_items << item[0]
        found = found + 1
      end

      retries = 0
      puts "[+] Found #{found} items on page #{page}" if @verbose
    end

    found_items.sort!
    found_items.uniq
  end

  # Save the file
  def save(items)
    items.sort!
    items.uniq!

    puts "[*] We have parsed #{items.length} #{@type}s"
    File.open(@file_name, 'w') { |f| f.puts(items) }
    puts "New #@file_name file created"
  end

end
