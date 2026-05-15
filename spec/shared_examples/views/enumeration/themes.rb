# frozen_string_literal: true

shared_examples 'App::Views::Enumeration::Themes' do
  let(:view)   { 'themes' }
  let(:plugin) { WPScan::Model::Theme }

  describe 'themes' do
    context 'when no themes found' do
      let(:expected_view) { File.join(view, 'none_found') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(themes: [])
      end
    end

    context 'when themes found' do
      let(:t1) { plugin.new('test-theme-1', target, found_by: 'Known Locations (Aggressive Detection)') }
      let(:t2) { plugin.new('test-theme-2', target, found_by: 'Urls In Homepage (Passive Detection)') }
      let(:themes) { [t1, t2] }
      let(:expected_view) { File.join(view, 'themes') }

      before do
        expect(target).to receive(:content_dir).at_least(1).and_return('wp-content')
        cache = double('cache')
        allow(cache).to receive(:get).and_return(nil)
        allow(cache).to receive(:set)
        allow(Typhoeus::Config).to receive(:cache).and_return(cache)
        stub_request(:head, /.*/)
        stub_request(:get, /.*/)
        stub_request(:get, /.*\.css\z/).to_return(body: '')
      end

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(themes: themes)
      end
    end
  end
end
