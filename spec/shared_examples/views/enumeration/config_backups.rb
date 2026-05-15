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
      let(:cb1) { config_backup.new("#{target_url}wp-config.php~", found_by: 'Direct Access (Aggressive Detection)') }
      let(:cb2) do
        config_backup.new("#{target_url}wp-config.php.bak", found_by: 'Direct Access (Aggressive Detection)')
      end
      let(:config_backups) { [cb1, cb2] }
      let(:expected_view) { File.join(view, 'config_backups') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(config_backups: config_backups)
      end
    end
  end
end
