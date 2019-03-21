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
      xit
    end
  end
end
