# encoding: UTF-8

class WpTarget < WebSite
  module WpConfigBackup

    # Checks to see if wp-config.php has a backup
    # See http://www.feross.org/cmsploit/
    # @return [ Array ] Backup config files
    def config_backup
      found       = []
      backups     = WpConfigBackup.config_backup_files
      browser     = Browser.instance
      hydra       = browser.hydra
      queue_count = 0

      backups.each do |file|
        file_url = @uri.merge(url_encode(file)).to_s
        request = browser.forge_request(file_url)

        request.on_complete do |response|
          if response.body[%r{define}i] and not response.body[%r{<\s?html}i]
            found << file_url
          end
        end

        hydra.queue(request)
        queue_count += 1

        if queue_count == browser.max_threads
          hydra.run
          queue_count = 0
        end
      end

      hydra.run

      found
    end

    # @return [ Array ]
    def self.config_backup_files
      %w{
        wp-config.php~ #wp-config.php# wp-config.php.save .wp-config.php.swp wp-config.php.swp wp-config.php.swo
        wp-config.php_bak wp-config.bak wp-config.php.bak wp-config.save wp-config.old wp-config.php.old
        wp-config.php.orig wp-config.orig wp-config.php.original wp-config.original wp-config.txt
      } # thanks to Feross.org for these
    end

  end
end
