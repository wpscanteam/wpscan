# frozen_string_literal: true

module WPScan
  module Finders
    class Finder
      # Module to provide an easy way to fingerprint things such as versions
      module Fingerprinter
        include Enumerator

        # @param [ Hash ] fingerprints The fingerprints
        # Format should be like the following:
        # {
        #   file_path_1: {
        #     md5_hash_1: version_1,
        #     md5_hash_2: [version_2]
        #   },
        #   file_path_2: {
        #     md5_hash_3: [version_1, version_2],
        #     md5_hash_4: version_3
        #   }
        # }
        # Note that the version can either be an array or a string
        #
        # @param [ Hash ] opts
        # @option opts [ Boolean ] :show_progression Wether or not to display the progress bar
        #
        # @yield [ Mixed, String, String ] version/s, url, hash The version associated to the
        #                                                       fingerprint of the url
        def fingerprint(fingerprints, opts = {})
          enum_opts = opts.merge(check_full_response: 200)

          enumerate(fingerprints.transform_keys { |k| target.url(k) }, enum_opts) do |res, fingerprint|
            md5sum = hexdigest(res.body)

            next unless fingerprint.key?(md5sum)

            yield fingerprint[md5sum], res.effective_url, md5sum
          end
        end

        # @return [ String ] The hashed value for the given body
        def hexdigest(body)
          Digest::MD5.hexdigest(body)
        end
      end
    end
  end
end
