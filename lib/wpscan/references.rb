# frozen_string_literal: true

module WPScan
  # References related to a vulnerability / finding.
  module References
    extend ActiveSupport::Concern

    # See ActiveSupport::Concern
    module ClassMethods
      # @return [ Array<Symbol> ]
      def references_keys
        @references_keys ||= %i[cve exploitdb url metasploit packetstorm securityfocus youtube wpvulndb]
      end
    end

    # @param [ Hash ] refs
    def references=(refs)
      @references = {}

      self.class.references_keys.each do |key|
        next unless refs.key?(key)

        @references[key] = if key == :youtube
                             Array(refs[:youtube]).map { |id| youtube_url(id) }
                           else
                             Array(refs[key]).map(&:to_s)
                           end
      end
    end

    # @return [ Hash ]
    def references
      @references ||= {}
    end

    # @return [ Array<String> ] All the references URLs
    def references_urls
      wpvulndb_urls + cve_urls + exploitdb_urls + urls + msf_urls +
        packetstorm_urls + securityfocus_urls + youtube_urls
    end

    # @return [ Array<String> ] The CVEs
    def cves
      references[:cve] || []
    end

    # @return [ Array<String> ]
    def cve_urls
      cves.reduce([]) { |acc, elem| acc << cve_url(elem) }
    end

    # @return [ String ] The URL to the CVE
    def cve_url(cve)
      "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-#{cve}"
    end

    # @return [ Array<String> ] The ExploitDB ID
    def exploitdb_ids
      references[:exploitdb] || []
    end

    # @return [ Array<String> ]
    def exploitdb_urls
      exploitdb_ids.reduce([]) { |acc, elem| acc << exploitdb_url(elem) }
    end

    # @return [ String ]
    def exploitdb_url(id)
      "https://www.exploit-db.com/exploits/#{id}/"
    end

    # @return [ Array<String> ]
    def urls
      references[:url] || []
    end

    # @return [ Array<String> ] The metasploit modules
    def msf_modules
      references[:metasploit] || []
    end

    # @return [ Array<String> ]
    def msf_urls
      msf_modules.reduce([]) { |acc, elem| acc << msf_url(elem) }
    end

    # @return [ String ] The URL to the metasploit module page
    def msf_url(mod)
      "https://www.rapid7.com/db/modules/#{mod.sub(%r{^/}, '')}/"
    end

    # @return [ Array<String> ] The Packetstormsecurity IDs
    def packetstorm_ids
      @packetstorm_ids ||= references[:packetstorm] || []
    end

    # @return [ Array<String> ]
    def packetstorm_urls
      packetstorm_ids.reduce([]) { |acc, elem| acc << packetstorm_url(elem) }
    end

    # @return [ String ]
    def packetstorm_url(id)
      "https://packetstormsecurity.com/files/#{id}/"
    end

    # @return [ Array<String> ] The Security Focus IDs
    def securityfocus_ids
      references[:securityfocus] || []
    end

    # @return [ Array<String> ]
    def securityfocus_urls
      securityfocus_ids.reduce([]) { |acc, elem| acc << securityfocus_url(elem) }
    end

    # @return [ String ]
    def securityfocus_url(id)
      "https://www.securityfocus.com/bid/#{id}/"
    end

    # @return [ Array<String> ]
    def youtube_urls
      references[:youtube] || []
    end

    # @return [ String ]
    def youtube_url(id)
      "https://www.youtube.com/watch?v=#{id}"
    end

    # @return [ Array<String> ] wpvulndb (now WPScan) reference IDs
    def wpvulndb_ids
      references[:wpvulndb] || []
    end

    # @return [ Array<String> ]
    def wpvulndb_urls
      wpvulndb_ids.reduce([]) { |acc, elem| acc << wpvulndb_url(elem) }
    end

    # @return [ String ]
    def wpvulndb_url(id)
      "https://wpscan.com/vulnerability/#{id}"
    end
  end
end
