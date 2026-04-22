# frozen_string_literal: true

module CMSScanner
  module Controller
    # CLI Options for the Core Controller
    class Core < Base
      def cli_options
        formats = NS::Formatter.availables

        [
          OptURL.new(['-u', '--url URL', 'The URL to scan'],
                     required_unless: %i[help hh version],
                     default_protocol: 'http'),
          OptBoolean.new(['--force', 'Do not check if target returns a 403'])
        ] + mixed_cli_options + [
          OptFilePath.new(['-o', '--output FILE', 'Output to FILE'], writable: true, exists: false),
          OptChoice.new(['-f', '--format FORMAT',
                         'Output results in the format supplied'], choices: formats),
          OptChoice.new(['--detection-mode MODE'],
                        choices: %w[mixed passive aggressive],
                        normalize: :to_sym,
                        default: :mixed),
          OptArray.new(['--scope DOMAINS',
                        'Comma separated (sub-)domains to consider in scope. ',
                        'Wildcard(s) allowed in the trd of valid domains, e.g: *.target.tld'], advanced: true)
        ] + cli_browser_options
      end

      def mixed_cli_options
        [
          OptBoolean.new(['-h', '--help', 'Display the simple help and exit']),
          OptBoolean.new(['--hh', 'Display the full help and exit']),
          OptBoolean.new(['--version', 'Display the version and exit']),
          OptBoolean.new(['--ignore-main-redirect', 'Ignore the main redirect (if any) and scan the target url'],
                         advanced: true),
          OptBoolean.new(['-v', '--verbose', 'Verbose mode']),
          OptBoolean.new(['--[no-]banner', 'Whether or not to display the banner'], default: true),
          OptPositiveInteger.new(['--max-scan-duration SECONDS',
                                  'Abort the scan if it exceeds the time provided in seconds'],
                                 advanced: true)
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_browser_options
        cli_browser_headers_options + [
          OptBoolean.new(['--random-user-agent', '--rua',
                          'Use a random user-agent for each scan']),
          OptFilePath.new(['--user-agents-list FILE-PATH',
                           'List of agents to use with --random-user-agent'],
                          exists: true,
                          advanced: true,
                          default: APP_DIR.join('user_agents.txt')),
          OptCredentials.new(['--http-auth login:password']),
          OptPositiveInteger.new(['-t', '--max-threads VALUE', 'The max threads to use'],
                                 default: 5),
          OptPositiveInteger.new(['--throttle MilliSeconds', 'Milliseconds to wait before doing another web request. ' \
                                                             'If used, the max threads will be set to 1.']),
          OptPositiveInteger.new(['--request-timeout SECONDS', 'The request timeout in seconds'],
                                 default: 60),
          OptPositiveInteger.new(['--connect-timeout SECONDS', 'The connection timeout in seconds'],
                                 default: 30),
          OptBoolean.new(['--disable-tls-checks',
                          'Disables SSL/TLS certificate verification, and downgrade to TLS1.0+ ' \
                          '(requires cURL 7.66 for the latter)'])
        ] + cli_browser_proxy_options + cli_browser_cookies_options + cli_browser_cache_options
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_browser_headers_options
        [
          OptString.new(['--user-agent VALUE', '--ua']),
          OptHeaders.new(['--headers HEADERS', 'Additional headers to append in requests'], advanced: true),
          OptString.new(['--vhost VALUE', 'The virtual host (Host header) to use in requests'], advanced: true)
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_browser_proxy_options
        [
          OptProxy.new(['--proxy protocol://IP:port',
                        'Supported protocols depend on the cURL installed']),
          OptCredentials.new(['--proxy-auth login:password'])
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_browser_cookies_options
        [
          OptString.new(['--cookie-string COOKIE',
                         'Cookie string to use in requests, ' \
                         'format: cookie1=value1[; cookie2=value2]']),
          OptFilePath.new(['--cookie-jar FILE-PATH', 'File to read and write cookies'],
                          writable: true,
                          readable: true,
                          create: true,
                          default: File.join(tmp_directory, 'cookie_jar.txt'))
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_browser_cache_options
        [
          OptInteger.new(['--cache-ttl TIME_TO_LIVE', 'The cache time to live in seconds'],
                         default: 600, advanced: true),
          OptBoolean.new(['--clear-cache', 'Clear the cache before the scan'], advanced: true),
          OptDirectoryPath.new(['--cache-dir PATH'],
                               readable: true,
                               writable: true,
                               create: true,
                               default: File.join(tmp_directory, 'cache'),
                               advanced: true)
        ]
      end
    end
  end
end
