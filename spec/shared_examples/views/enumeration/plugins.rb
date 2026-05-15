# frozen_string_literal: true

shared_examples 'App::Views::Enumeration::Plugins' do
  let(:view)   { 'plugins' }
  let(:plugin) { WPScan::Model::Plugin }

  describe 'plugins' do
    context 'when no plugins found' do
      let(:expected_view) { File.join(view, 'none_found') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(plugins: [])
      end
    end

    context 'when plugins found' do
      let(:p1) { plugin.new('test-plugin-1', target, found_by: 'Known Locations (Aggressive Detection)') }
      let(:p2) { plugin.new('test-plugin-2', target, found_by: 'Urls In Homepage (Passive Detection)') }
      let(:plugins) { [p1, p2] }
      let(:expected_view) { File.join(view, 'plugins') }

      before do
        expect(target).to receive(:content_dir).at_least(1).and_return('wp-content')
        stub_request(:head, /.*/)
        stub_request(:get, /.*/)
      end

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(plugins: plugins)
      end
    end
  end
end
