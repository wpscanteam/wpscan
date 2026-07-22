# frozen_string_literal: true

# Clears the WPSCAN_API_TOKEN and WPSCAN_ENTERPRISE_DB_TOKEN environment variables around each
# example (restoring them afterwards), so that tokens set in the environment running the suite
# don't leak into the examples. Examples needing a token set it in their own before/around.
RSpec.shared_context 'with cleared API token ENV' do
  around do |example|
    api_key        = WPScan::Controller::VulnApi::ENV_KEY
    enterprise_key = WPScan::Controller::VulnApi::ENTERPRISE_ENV_KEY

    original_api_token        = ENV.fetch(api_key, nil)
    original_enterprise_token = ENV.fetch(enterprise_key, nil)

    ENV.delete(api_key)
    ENV.delete(enterprise_key)
    example.run
  ensure
    original_api_token ? ENV[api_key] = original_api_token : ENV.delete(api_key)
    original_enterprise_token ? ENV[enterprise_key] = original_enterprise_token : ENV.delete(enterprise_key)
  end
end
