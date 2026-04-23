# frozen_string_literal: true

shared_examples 'App::Views::Core' do
  let(:controller) { WPScan::Controller::Core.new }
  let(:start)      { Time.at(1_414_670_521).in_time_zone('Europe/London') }
  let(:tpl_vars)   { { url: target_url, ip: '127.0.0.1', start_time: start } }

  describe 'version' do
    let(:view) { 'version' }

    it 'outputs the expected string' do
      @tpl_vars = {}

      @expected_output = if parsed_options[:format] == 'json'
                           JSON.pretty_generate('version' => WPScan::VERSION)
                         else
                           "Version: #{WPScan::VERSION}\n"
                         end
    end
  end

  describe 'help' do
    let(:view) { 'help' }

    it 'outputs the expected string' do
      @tpl_vars = { help: 'Help Message from OptionParser' }
    end
  end

  describe 'started' do
    let(:view) { 'started' }

    context 'when the target url and the effective_url are the same' do
      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(start_memory: 10, effective_url: target_url)
      end
    end

    context 'when target url != effective_url' do
      let(:expected_view) { 'started_effective_url' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(start_memory: 10, effective_url: "#{target_url}home")
      end
    end
  end

  describe 'finished' do
    let(:view) { 'finished' }

    it 'outputs the expected string' do
      @tpl_vars = tpl_vars.merge(
        stop_time: Time.at(1_414_670_523).in_time_zone('Europe/London'),
        used_memory: 100,
        elapsed: 2,
        requests_done: 10,
        cached_requests: 1,
        data_sent: 1000,
        data_received: 2000
      )
    end
  end
end
