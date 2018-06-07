# encoding: UTF-8

class WebSite
  module SqlFileExport

    # Checks if a .sql file exists
    # @return [ Array ]
    def sql_file_export
      backup_files = []

      self.sql_file_export_urls.each do |url|
        response = Browser.get(url)
        backup_files << url if response.code == 200 && response.body =~ /INSERT INTO/
      end

      backup_files
    end

    # Gets a .sql export file URL
    # @return [ Array ]
    def sql_file_export_urls
      urls  = []
      files = ["#{@uri.host[/(^[\w|-]+)/,1]}.sql", 'backup.sql', 'database.sql', 'dump.sql']

      files.each do |file|
        urls << @uri.clone.merge(file).to_s
      end

      urls
    end
  end
end
