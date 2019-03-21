# frozen_string_literal: true

shared_examples 'App::Views::Enumeration::DbExports' do
  let(:view)      { 'db_exports' }
  let(:db_export) { WPScan::Model::DbExport }

  describe 'db_exports' do
    context 'when no file found' do
      let(:expected_view) { File.join(view, 'none_found') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(db_exports: [])
      end
    end

    context 'when files found' do
      xit
    end
  end
end
