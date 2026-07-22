# frozen_string_literal: true

describe WPScan::Controller::VulnApi do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://ex.lo/' }
  let(:cli_args)       { "--url #{target_url}" }

  include_context 'with cleared API token ENV'

  before do
    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
    WPScan::DB::VulnApi.instance_variable_set(:@default_request_params, nil)
    WPScan::DB::VulnApi.token = nil
    WPScan::DB::VulnApi.local_db = nil
  end

  describe '#cli_options' do
    its(:cli_options) { should_not be_empty }
    its(:cli_options) { should be_a Array }

    it 'contains the correct options' do
      expect(controller.cli_options.map(&:to_sym)).to eq %i[api_token enterprise_db_token proxy_target_only]
    end
  end

  describe '.validate_api_tokens!' do
    context 'when no token is supplied' do
      it 'does not raise an error' do
        expect { described_class.validate_api_tokens! }.to_not raise_error
      end
    end

    context 'when only --api-token is supplied' do
      let(:cli_args) { "#{super()} --api-token token" }

      it 'does not raise an error' do
        expect { described_class.validate_api_tokens! }.to_not raise_error
      end
    end

    context 'when only --enterprise-db-token is supplied' do
      let(:cli_args) { "#{super()} --enterprise-db-token ent-token" }

      it 'does not raise an error' do
        expect { described_class.validate_api_tokens! }.to_not raise_error
      end
    end

    context 'when both tokens are supplied via the CLI' do
      let(:cli_args) { "#{super()} --api-token token --enterprise-db-token ent-token" }

      it 'raises a ConflictingApiTokens error' do
        expect { described_class.validate_api_tokens! }.to raise_error(WPScan::Error::ConflictingApiTokens)
      end
    end

    context 'when both tokens are supplied via the ENV' do
      before do
        ENV[described_class::ENV_KEY]            = 'token-from-env'
        ENV[described_class::ENTERPRISE_ENV_KEY] = 'ent-token-from-env'
      end

      it 'raises a ConflictingApiTokens error' do
        expect { described_class.validate_api_tokens! }.to raise_error(WPScan::Error::ConflictingApiTokens)
      end
    end
  end

  describe '#before_scan' do
    context 'when no --api-token provided' do
      its(:before_scan) { should be nil }
    end

    context 'when --api-token given' do
      let(:cli_args) { "#{super()} --api-token token" }

      context 'when the token is invalid' do
        before { expect(WPScan::DB::VulnApi).to receive(:status).and_return('status' => 'forbidden') }

        it 'raise an InvalidApiToken error' do
          expect { controller.before_scan }.to raise_error(WPScan::Error::InvalidApiToken)
        end
      end

      context 'when the token is valid' do
        context 'when the limit has been reached' do
          before do
            expect(WPScan::DB::VulnApi)
              .to receive(:status)
              .and_return('success' => true, 'plan' => 'free', 'requests_remaining' => 0)
          end

          it 'raises an ApiLimitReached error' do
            expect { controller.before_scan }.to raise_error(WPScan::Error::ApiLimitReached)
          end
        end

        context 'when a HTTP error, like a timeout' do
          before do
            expect(WPScan::DB::VulnApi)
              .to receive(:status)
              .and_return(
                'http_error' => WPScan::Error::HTTP.new(
                  Typhoeus::Response.new(effective_url: 'mock-url', return_code: 28)
                )
              )
          end

          it 'raises an API connection error' do
            expect { controller.before_scan }
              .to raise_error(
                WPScan::Error::ApiConnectionError,
                'Unable to connect to the WPScan API: HTTP Error: mock-url (Timeout was reached). ' \
                'Please check https://status.wpscan.com/ for service status.'
              )
          end
        end

        context 'when the token is valid and no HTTP error' do
          before do
            expect(WPScan::DB::VulnApi)
              .to receive(:status)
              .and_return('success' => true, 'plan' => 'free', 'requests_remaining' => requests)
          end

          context 'when limited requests' do
            let(:requests) { 100 }

            it 'sets the token and does not raise an error' do
              expect { controller.before_scan }.to_not raise_error

              expect(WPScan::DB::VulnApi.token).to eql 'token'
            end

            context 'when unlimited requests' do
              let(:requests) { 'Unlimited' }

              it 'sets the token and does not raise an error' do
                expect { controller.before_scan }.to_not raise_error

                expect(WPScan::DB::VulnApi.token).to eql 'token'
              end
            end
          end
        end
      end
    end

    context 'when token in ENV' do
      before do
        ENV[described_class::ENV_KEY] = 'token-from-env'

        expect(WPScan::DB::VulnApi)
          .to receive(:status)
          .and_return('success' => true, 'plan' => 'free', 'requests_remaining' => 'Unlimited')
      end

      it 'sets the token and does not raise an error' do
        expect { controller.before_scan }.to_not raise_error

        expect(WPScan::DB::VulnApi.token).to eql 'token-from-env'
      end
    end

    context 'when --enterprise-db-token given' do
      let(:cli_args) { "#{super()} --enterprise-db-token ent-token" }

      context 'when the local DB dumps are present' do
        before { allow(File).to receive(:exist?).and_return(true) }

        it 'enables local DB mode without querying the API' do
          expect(WPScan::DB::VulnApi).to_not receive(:status)

          expect { controller.before_scan }.to_not raise_error

          expect(WPScan::DB::VulnApi.local_db).to be true
          expect(WPScan::DB::VulnApi.token).to be nil
        end
      end

      context 'when a local DB dump is missing' do
        before { allow(File).to receive(:exist?).and_return(false) }

        it 'raises a MissingEnterpriseDatabaseFile error' do
          expect { controller.before_scan }.to raise_error(WPScan::Error::MissingEnterpriseDatabaseFile)
        end
      end

      context 'when --api-token is also given' do
        let(:cli_args) { "#{super()} --api-token token" }

        it 'raises a ConflictingApiTokens error' do
          expect { controller.before_scan }.to raise_error(WPScan::Error::ConflictingApiTokens)
        end
      end

      context 'when WPSCAN_API_TOKEN is also set in the ENV' do
        before { ENV[described_class::ENV_KEY] = 'token-from-env' }

        it 'raises a ConflictingApiTokens error' do
          expect { controller.before_scan }.to raise_error(WPScan::Error::ConflictingApiTokens)
        end
      end
    end
  end
end
