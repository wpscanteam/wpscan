module WPScan
  module Finders
    module InterestingFindings
      # DuplicatorInstallerLog finder
      class DuplicatorInstallerLog < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          url = target.url('installer-log.txt')
          res = Browser.get(url)

          return unless res.body =~ /DUPLICATOR INSTALL-LOG/

          Model::DuplicatorInstallerLog.new(
            url,
            confidence: 100,
            found_by: DIRECT_ACCESS,
            references: { url: 'https://www.exploit-db.com/ghdb/3981/' }
          )
        end
      end
    end
  end
end
