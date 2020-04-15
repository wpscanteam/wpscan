# frozen_string_literal: true

module WPScan
  # References module (which should be included along with the CMSScanner::References)
  # to allow the use of the wpvulndb and youtube references.
  # Notes: The youtube references are not handled the same way all the others, especialy in the JSON output
  #        as we output the full URL and not just the ID. Hence the override of the references= method
  module References
    extend ActiveSupport::Concern

    # See ActiveSupport::Concern
    module ClassMethods
      # @return [ Array<Symbol> ]
      def references_keys
        @references_keys ||= super << :wpvulndb << :youtube
      end
    end

    # @param [ Hash ] refs
    def references=(refs)
      @references = {}

      self.class.references_keys.each do |key|
        next unless refs.key?(key)

        @references[key] = if key == :youtube
                             [*refs[:youtube]].map { |id| youtube_url(id) }
                           else
                             [*refs[key]].map(&:to_s)
                           end
      end
    end

    def references_urls
      wpvulndb_urls + super + youtube_urls
    end

    def wpvulndb_ids
      references[:wpvulndb] || []
    end

    def wpvulndb_urls
      wpvulndb_ids.reduce([]) { |acc, elem| acc << wpvulndb_url(elem) }
    end

    def wpvulndb_url(id)
      "https://wpvulndb.com/vulnerabilities/#{id}"
    end

    def youtube_urls
      references[:youtube] || []
    end

    def youtube_url(id)
      "https://www.youtube.com/watch?v=#{id}"
    end
  end
end
