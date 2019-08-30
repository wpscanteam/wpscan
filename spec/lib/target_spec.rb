# frozen_string_literal: true

describe WPScan::Target do
  subject(:target) { described_class.new(url, opts) }
  let(:url)        { 'http://ex.lo' }
  let(:opts)       { {} }

  it_behaves_like WPScan::Target::Platform::WordPress

  describe 'xmlrpc' do
    before do
      allow(target).to receive(:sub_dir)

      expect(target).to receive(:interesting_findings).and_return(interesting_findings)
    end

    context 'when no interesting_findings' do
      let(:interesting_findings) { [] }

      its(:xmlrpc) { should be_nil }
    end

    context 'when interesting_findings' do
      let(:interesting_findings) { ['aa', CMSScanner::Model::RobotsTxt.new(target.url)] }

      context 'when no XMLRPC' do
        its(:xmlrpc) { should be_nil }
      end

      context 'when XMLRPC' do
        let(:xmlrpc) { WPScan::Model::XMLRPC.new(target.url('xmlrpc.php')) }
        let(:interesting_findings) { super() << xmlrpc }

        its(:xmlrpc) { should eq xmlrpc }
      end
    end
  end

  %i[wp_version main_theme plugins themes timthumbs config_backups db_exports medias users].each do |method|
    describe "##{method}" do
      before do
        return_value = %i[wp_version main_theme].include?(method) ? false : []

        expect(WPScan::Finders.const_get("#{method.to_s.camelize}::Base"))
          .to receive(:find).with(target, opts).and_return(return_value)
      end

      after { target.send(method, opts) }

      let(:opts) { {} }

      context 'when no options' do
        it 'calls the finder with the correct arguments' do
          # handled by before hook
        end
      end

      context 'when options' do
        let(:opts) { { mode: :passive, somthing: 'k' } }

        it 'calls the finder with the corect arguments' do
          # handled by before hook
        end
      end

      context 'when called multiple times' do
        it 'calls the finder only once' do
          target.send(method, opts)
        end
      end
    end
  end

  describe '#vulnerable?' do
    context 'when all attributes are nil' do
      it { should_not be_vulnerable }
    end

    context 'when wp_version is not found' do
      before { target.instance_variable_set(:@wp_version, false) }

      it { should_not be_vulnerable }
    end

    context 'when wp_version found' do
      before do
        expect(wp_version)
          .to receive(:db_data)
          .and_return(vuln_api_data_for("wordpresses/#{wp_version.number.tr('.', '')}"))

        target.instance_variable_set(:@wp_version, wp_version)
      end

      context 'when not vulnerable' do
        let(:wp_version) { WPScan::Model::WpVersion.new('4.0') }

        it { should_not be_vulnerable }
      end

      context 'when vulnerable' do
        let(:wp_version) { WPScan::Model::WpVersion.new('3.8.1') }

        it { should be_vulnerable }
      end
    end

    context 'when config_backups' do
      before do
        target.instance_variable_set(:@config_backups, [WPScan::Model::ConfigBackup.new(target.url('/a-file-url'))])
      end

      it { should be_vulnerable }
    end

    context 'when db_exports' do
      before do
        target.instance_variable_set(:@db_exports, [WPScan::Model::DbExport.new(target.url('/wordpress.sql'))])
      end

      it { should be_vulnerable }
    end

    context 'when users' do
      before do
        target.instance_variable_set(:@users,
                                     [WPScan::Model::User.new('u1'),
                                      WPScan::Model::User.new('u2')])
      end

      context 'when no passwords' do
        it { should_not be_vulnerable }
      end

      context 'when at least one password has been found' do
        before { target.users[1].password = 'owned' }

        it { should be_vulnerable }
      end
    end
  end
end
