module WPScan
  # Error raised when there is a missing  DB file and --no-update supplied
  class MissingDatabaseFile < StandardError
    def to_s
      'Update required, you can not run a scan if a database file is missing.'
    end
  end
end
