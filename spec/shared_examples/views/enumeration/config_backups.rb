# frozen_string_literal: true

shared_examples 'App::Views::Enumeration::ConfigBackups' do
  let(:view)          { 'config_backups' }
  let(:config_backup) { WPScan::Model::ConfigBackup }

  describe 'config_backups' do
    context 'when no backups found' do
      let(:expected_view) { File.join(view, 'none_found') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(config_backups: [])
      end
    end

    context 'when backups found' do
      xit
    end
  end
end
