# frozen_string_literal: true

shared_examples 'App::Views::WpVersion' do
  let(:controller) { WPScan::Controller::WpVersion.new }
  let(:tpl_vars)   { { url: target_url } }

  describe 'version' do
    let(:view) { 'version' }

    context 'when the version is nil' do
      let(:expected_view) { 'not_found' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(version: nil)
      end
    end

    context 'when the version is not nil' do
      let(:version) { WPScan::Model::WpVersion.new('4.0', found_by: 'rspec') }
      before { allow(version).to receive(:db_data).and_return(vuln_api_data_for('wordpresses/40')) }

      context 'when confirmed_by is empty' do
        context 'when no interesting_entries' do
          let(:expected_view) { 'not_confirmed_no_entries' }

          it 'outputs the expected string' do
            @tpl_vars = tpl_vars.merge(version: version)
          end
        end

        context 'when interesting_entries' do
          let(:expected_view) { 'not_confirmed_entries' }

          it 'outputs the expected string' do
            version.interesting_entries << 'IE1' << 'IE2'

            @tpl_vars = tpl_vars.merge(version: version)
          end
        end
      end

      context 'when confirmed_by is not empty' do
        let(:confirmed_1) do
          v = version.dup
          v.found_by = 'Confirmed 1'
          v.interesting_entries << 'IE1'
          v
        end

        let(:confirmed_2) do
          v = version.dup
          v.found_by = 'Confirmed 2'
          v.interesting_entries << 'IE1' << 'IE2'
          v
        end

        context 'when one confirmed_by' do
          let(:expected_view) { 'confirmed_one' }

          it 'outputs the expected string' do
            f = WPScan::Finders::Findings.new << version << confirmed_1

            @tpl_vars = tpl_vars.merge(version: f.first)
          end
        end

        context 'when multiple confirmed_by' do
          let(:expected_view) { 'confirmed_multiples' }

          it 'outputs the expected string' do
            f = WPScan::Finders::Findings.new << version << confirmed_1 << confirmed_2

            @tpl_vars = tpl_vars.merge(version: f.first)
          end
        end
      end
    end

    context 'when the version is vulnerable' do
      let(:expected_view) { 'with_vulns' }
      let(:version) { WPScan::Model::WpVersion.new('3.8.1', found_by: 'rspec') }

      before { allow(version).to receive(:db_data).and_return(vuln_api_data_for('wordpresses/381')) }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(version: version)
      end
    end
  end
end
