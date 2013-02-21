# encoding: UTF-8
#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

module WpConfigBackup

  # Checks to see if wp-config.php has a backup
  # See http://www.feross.org/cmsploit/
  # return an array of backup config files url
  def config_backup
    found       = []
    backups     = WpConfigBackup.config_backup_files
    browser     = Browser.instance
    hydra       = browser.hydra
    queue_count = 0

    backups.each do |file|
      file_url = @uri.merge(URI.escape(file)).to_s
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

  # @return Array
  def self.config_backup_files
    %w{
      wp-config.php~ #wp-config.php# wp-config.php.save wp-config.php.swp wp-config.php.swo wp-config.php_bak
      wp-config.bak wp-config.php.bak wp-config.save wp-config.old wp-config.php.old wp-config.php.orig
      wp-config.orig wp-config.php.original wp-config.original wp-config.txt
    } # thanks to Feross.org for these
  end

end
