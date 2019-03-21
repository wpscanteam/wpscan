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
      xit
    end
  end
end
