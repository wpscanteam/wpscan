module WPScan
  # WP Version
  class WpVersion < CMSScanner::Version
    include Vulnerable

    def initialize(number, opts = {})
      raise InvalidWordPressVersion unless WpVersion.valid?(number.to_s)

      super(number, opts)
    end

    # @param [ String ] number
    #
    # @return [ Boolean ] true if the number is a valid WP version, false otherwise
    def self.valid?(number)
      all.include?(number)
    end

    # @return [ Array<String> ] All the version numbers
    def self.all
      return @all_numbers if @all_numbers

      @all_numbers = []

      DB::Fingerprints.wp_fingerprints.each_value do |fp|
        fp.each_value do |versions|
          versions.each do |version|
            @all_numbers << version unless @all_numbers.include?(version)
          end
        end
      end

      @all_numbers.sort! { |a, b| Gem::Version.new(b) <=> Gem::Version.new(a) }
    end

    # @return [ JSON ]
    def db_data
      DB::Version.db_data(number)
    end

    # @return [ Array<Vulnerability> ]
    def vulnerabilities
      return @vulnerabilities if @vulnerabilities

      @vulnerabilities = []

      [*db_data['vulnerabilities']].each do |json_vuln|
        @vulnerabilities << Vulnerability.load_from_json(json_vuln)
      end

      @vulnerabilities
    end
  end
end
