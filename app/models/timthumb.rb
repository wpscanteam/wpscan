# frozen_string_literal: true

module WPScan
  module Model
    # Timthumb
    class Timthumb < InterestingFinding
      include Vulnerable

      attr_reader :version_detection_opts

      # @param [ String ] url
      # @param [ Hash ] opts
      # @option opts [ Symbol ] :mode The mode to use to detect the version
      def initialize(url, opts = {})
        super(url, opts)

        @version_detection_opts = opts[:version_detection] || {}
      end

      # @param [ Hash ] opts
      #
      # @return [ Model::Version, false ]
      def version(opts = {})
        @version = Finders::TimthumbVersion::Base.find(self, version_detection_opts.merge(opts)) if @version.nil?

        @version
      end

      # @return [ Array<Vulnerability> ]
      def vulnerabilities
        vulns = []

        vulns << rce_webshot_vuln if version == false || version > '1.35' && version < '2.8.14' && webshot_enabled?
        vulns << rce_132_vuln if version == false || version < '1.33'

        vulns
      end

      # @return [ Vulnerability ] The RCE in the <= 1.32
      def rce_132_vuln
        Vulnerability.new(
          'Timthumb <= 1.32 Remote Code Execution',
          references: { exploitdb: ['17602'] },
          type: 'RCE',
          fixed_in: '1.33'
        )
      end

      # @return [ Vulnerability ] The RCE due to the WebShot in the > 1.35 (or >= 2.0) and <= 2.8.13
      def rce_webshot_vuln
        Vulnerability.new(
          'Timthumb <= 2.8.13 WebShot Remote Code Execution',
          references: {
            url: ['http://seclists.org/fulldisclosure/2014/Jun/117', 'https://github.com/wpscanteam/wpscan/issues/519'],
            cve: '2014-4663'
          },
          type: 'RCE',
          fixed_in: '2.8.14'
        )
      end

      # @return [ Boolean ]
      def webshot_enabled?
        res = Browser.get(url, params: { webshot: 1, src: "http://#{default_allowed_domains.sample}" })

        /WEBSHOT_ENABLED == true/.match?(res.body) ? false : true
      end

      # @return [ Array<String> ] The default allowed domains (between the 2.0 and 2.8.13)
      def default_allowed_domains
        %w[flickr.com picasa.com img.youtube.com upload.wikimedia.org]
      end
    end
  end
end
