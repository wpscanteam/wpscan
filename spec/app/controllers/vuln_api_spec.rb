# frozen_string_literal: true

describe WPScan::Controller::VulnApi do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://ex.lo/' }
  let(:cli_args)       { "--url #{target_url}" }

  before do
    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
    WPScan::DB::VulnApi.instance_variable_set(:@default_request_params, nil)
  end

  describe '#cli_options' do
    its(:cli_options) { should_not be_empty }
    its(:cli_options) { should be_a Array }

    it 'contains to correct options' do
      expect(controller.cli_options.map(&:to_sym)).to eq %i[api_token]
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

          it 'raises an HTTP error' do
            expect { controller.before_scan }
              .to raise_error(WPScan::Error::HTTP, 'HTTP Error: mock-url (Timeout was reached)')
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
  end
end
