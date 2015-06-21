# encoding: UTF-8

class WpTimthumb < WpItem
  module Vulnerable
    # @return [ Vulnerabilities ]
    def vulnerabilities
      vulns = Vulnerabilities.new

      [:check_rce_132, :check_rce_webshot].each do |method|
        vuln = self.send(method)

        vulns << vuln if vuln
      end
      vulns
    end

    def check_rce_132
      rce_132_vuln unless VersionCompare.lesser_or_equal?('1.33', version)
    end

    # Vulnerable versions : > 1.35 (or >= 2.0) and < 2.8.14
    def check_rce_webshot
      return if VersionCompare.lesser_or_equal?('2.8.14', version) || VersionCompare.lesser_or_equal?(version, '1.35')

      response = Browser.get(uri.merge('?webshot=1&src=http://' + default_allowed_domains.sample))

      rce_webshot_vuln unless response.body =~ /WEBSHOT_ENABLED == true/
    end

    # @return [ Array<String> ] The default allowed domains (between the 2.0 and 2.8.13)
    def default_allowed_domains
      %w(flickr.com picasa.com img.youtube.com upload.wikimedia.org)
    end

    # @return [ Vulnerability ] The RCE in the <= 1.32
    def rce_132_vuln
      Vulnerability.new(
        'Timthumb <= 1.32 Remote Code Execution',
        'RCE',
        { exploitdb: ['17602'] },
        '1.33'
      )
    end

    # @return [ Vulnerability ] The RCE due to the WebShot in the <= 2.8.13
    def rce_webshot_vuln
      Vulnerability.new(
        'Timthumb <= 2.8.13 WebShot Remote Code Execution',
        'RCE',
        { url: ['http://seclists.org/fulldisclosure/2014/Jun/117'] },
        '2.8.14'
      )
    end
  end
end
