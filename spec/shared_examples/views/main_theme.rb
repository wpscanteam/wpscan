# frozen_string_literal: true

shared_examples 'App::Views::MainTheme' do
  let(:controller) { WPScan::Controller::MainTheme.new }
  let(:tpl_vars)   { { url: target_url } }
  let(:theme)      { WPScan::Model::Theme.new(theme_name, target, found_by: 'rspec') }

  describe 'main_theme' do
    let(:view) { 'theme' }

    context 'when no theme found' do
      let(:expected_view) { 'not_found' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(theme: nil)
      end
    end

    context 'when a theme found' do
      let(:theme_name) { 'test' }

      before do
        expect(target).to receive(:content_dir).at_least(1).and_return('wp-content')

        # Stub all requests to 200, to detect the readme.
        # Detection of the error_log will fail as the empty body won't match the patterns
        stub_request(:head, /.*/)
        stub_request(:get, /.*/)

        stub_request(:get, /.*\.css\z/)
          .to_return(body: File.read(FIXTURES.join('models', 'theme', 'style.css')))
      end

      context 'when no verbose' do
        let(:expected_view) { 'no_verbose' }

        it 'outputs the expected string' do
          expect(theme).to receive(:version).at_least(1)

          @tpl_vars = tpl_vars.merge(theme: theme)
        end
      end

      context 'when verbose' do
        let(:expected_view) { 'verbose' }

        it 'outputs the expected string' do
          expect(theme)
            .to receive(:version)
            .at_least(1)
            .and_return(WPScan::Model::Version.new('3.2', found_by: 'style'))

          @tpl_vars = tpl_vars.merge(theme: theme, verbose: true)
        end
      end

      context 'when vulnerable' do
        let(:expected_view) { 'vulnerable' }
        let(:theme_name)    { 'dignitas-themes' }

        it 'outputs the expected string' do
          expect(theme).to receive(:version).at_least(1)
          allow(theme).to receive(:db_data).and_return(vuln_api_data_for('themes/dignitas-themes'))

          @tpl_vars = tpl_vars.merge(theme: theme, verbose: true)
        end
      end
    end
  end
end
