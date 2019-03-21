# frozen_string_literal: true

describe WPScan::Model::Timthumb do
  subject(:timthumb) { described_class.new(url, opts) }
  let(:url)          { 'http://wp.lab/wp-content/timthumb.php' }
  let(:fixtures)     { FIXTURES.join('models', 'timthumb') }
  let(:opts)         { {} }

  describe '#new' do
    its(:url) { should eql url }
  end

  # The fact that the finders should only be called once is handled by the
  # vulnerabilities, vulnerable? specs below
  describe '#version' do
    after do
      expect(WPScan::Finders::TimthumbVersion::Base).to receive(:find).with(timthumb, @expected_opts)

      timthumb.version(version_opts)
    end

    context 'when no :version_detection' do
      context 'when no :mode opt supplied' do
        let(:version_opts) { { something: 'k' } }

        it 'calls the finder with the correct parameters' do
          @expected_opts = version_opts
        end
      end

      context 'when :mode supplied' do
        let(:version_opts) { { mode: :passive } }

        it 'calls the finder with the correct parameters' do
          @expected_opts = { mode: :passive }
        end
      end
    end

    context 'when :version_detection' do
      let(:opts) { super().merge(mode: :passive) }

      context 'when no :mode' do
        let(:version_opts) { {} }

        it 'calls the finder with the :passive mode' do
          @expected_opts = version_opts
        end
      end

      context 'when :mode' do
        let(:version_opts) { { mode: :mixed } }

        it 'calls the finder with the :mixed mode' do
          @expected_opts = { mode: :mixed }
        end
      end
    end
  end

  describe '#webshot_enabled?' do
    before do
      stub_request(:get, /#{timthumb.url}\?src=.*&webshot=1/i)
        .to_return(body: File.read(fixtures.join(fixture)))
    end

    context 'when enabled' do
      let(:fixture) { '2.8.13_webshot_enabled.html' }

      its(:webshot_enabled?) { should eql true }
    end

    context 'when disabled' do
      let(:fixture) { '2.8.13_webshot_disabled.html' }

      its(:webshot_enabled?) { should eql false }
    end
  end

  describe '#vulnerabilities, #vulnerable?' do
    before { expect(WPScan::Finders::TimthumbVersion::Base).to receive(:find).and_return(version) }

    context 'when no version' do
      let(:version) { false }

      its(:vulnerabilities) { should eq([timthumb.rce_webshot_vuln, timthumb.rce_132_vuln]) }
      it { should be_vulnerable }
    end

    context 'when version' do
      let(:version) { WPScan::Model::Version.new(version_number) }

      context 'when version >= 2.8.14' do
        let(:version_number) { '2.8.14' }

        its(:vulnerabilities) { should eq([]) }
        it { should_not be_vulnerable }
      end

      context 'when version < 1.33' do
        let(:version_number) { '1.20' }

        its(:vulnerabilities) { should eq([timthumb.rce_132_vuln]) }
        it { should be_vulnerable }
      end

      context 'when version > 1.35 and < 2.8.13' do
        let(:version_number) { '2.8.10' }

        context 'when webshot enabled' do
          before { expect(timthumb).to receive(:webshot_enabled?).and_return(true) }

          its(:vulnerabilities) { should eq([timthumb.rce_webshot_vuln]) }
          it { should be_vulnerable }
        end

        context 'when webshot disabled' do
          before { expect(timthumb).to receive(:webshot_enabled?).and_return(false) }

          its(:vulnerabilities) { should eq([]) }
          it { should_not be_vulnerable }
        end
      end
    end
  end
end
