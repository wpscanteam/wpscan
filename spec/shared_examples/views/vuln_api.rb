# frozen_string_literal: true

shared_examples 'App::Views::VulnApi' do
  let(:controller) { WPScan::Controller::VulnApi.new }
  let(:tpl_vars)   { { url: target_url } }

  describe 'status' do
    let(:view) { 'status' }

    context 'when no api token is given' do
      let(:expected_view) { 'no_token' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(status: {})
      end
    end

    context 'when http error' do
      let(:expected_view) { 'http_error' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(
          status: {
            'http_error' => WPScan::Error::HTTP.new(Typhoeus::Response.new(effective_url: 'url', return_code: 28))
          }
        )
      end
    end

    context 'when no more remaining requests' do
      let(:expected_view) { 'no_more_requests' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(
          status: { 'success': true, 'plan' => 'free', 'requests_remaining' => 0 },
          api_requests: 3
        )
      end
    end

    context 'when everything is fine' do
      let(:expected_view) { 'all_ok' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(
          status: { 'success': true, 'plan' => 'paid', 'requests_remaining' => 120 },
          api_requests: 3
        )
      end
    end

    context 'when unlimited requests' do
      let(:expected_view) { 'unlimited_requests' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(
          status: { 'success': true, 'plan' => 'enterprise', 'requests_remaining' => 'Unlimited' },
          api_requests: 3
        )
      end
    end
  end
end
