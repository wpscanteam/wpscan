# encoding: UTF-8

class WebSite
  module SqlFileExport

    # Checks if a .sql file exists
    # @return [ Array ]
    def sql_file_export
      export_files = []

      self.sql_file_export_urls.each do |url|
        response = Browser.get(url)
        export_files << url if response.code == 200 && response.body =~ /INSERT INTO/
      end

      export_files
    end

    # Gets a .sql export file URL
    # @return [ Array ]
    def sql_file_export_urls
      urls  = []
      host  = @uri.host[/(^[\w|-]+)/,1]

      files = ["#{host}.sql", "#{host}.sql.gz", "#{host}.zip", 'db.sql', 'site.sql', 'database.sql', 
        'data.sql', 'backup.sql','dump.sql', 'db_backup.sql', 'dbdump.sql', 'wordpress.sql', 'mysql.sql']

      files.each do |file|
        urls << @uri.clone.merge(file).to_s
      end

      urls
    end
  end
end
