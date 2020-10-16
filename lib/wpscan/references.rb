# frozen_string_literal: true

module WPScan
  # References module (which should be included along with the CMSScanner::References)
  # to allow the use of the wpvulndb reference.
  module References
    extend ActiveSupport::Concern

    # See ActiveSupport::Concern
    module ClassMethods
      # @return [ Array<Symbol> ]
      def references_keys
        @references_keys ||= super << :wpvulndb
      end
    end

    def references_urls
      wpvulndb_urls + super
    end

    def wpvulndb_ids
      references[:wpvulndb] || []
    end

    def wpvulndb_urls
      wpvulndb_ids.reduce([]) { |acc, elem| acc << wpvulndb_url(elem) }
    end

    def wpvulndb_url(id)
      "https://wpscan.com/vulnerability/#{id}"
    end
  end
end
