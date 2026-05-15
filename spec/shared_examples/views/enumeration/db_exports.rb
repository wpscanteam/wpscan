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
      let(:db1) { db_export.new("#{target_url}database.sql", found_by: 'Direct Access (Aggressive Detection)') }
      let(:db2) { db_export.new("#{target_url}db_backup.sql.gz", found_by: 'Direct Access (Aggressive Detection)') }
      let(:db_exports) { [db1, db2] }
      let(:expected_view) { File.join(view, 'db_exports') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(db_exports: db_exports)
      end
    end
  end
end
