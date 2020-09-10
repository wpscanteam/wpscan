# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::DuplicatorInstallerLog do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'duplicator_installer_log') }
  let(:filename)   { 'installer-log.txt' }
  let(:log_url)    { target.url(filename) }

  describe '#aggressive' do
    before do
      expect(target).to receive(:sub_dir).at_least(1).and_return(false)
      expect(target).to receive(:head_or_get_params).and_return(method: :head)
    end

    context 'when not a 200' do
      it 'return nil' do
        stub_request(:head, log_url).to_return(status: 404)

        expect(finder.aggressive).to eql nil
      end
    end

    context 'when a 200' do
      before do
        stub_request(:head, log_url)
        stub_request(:get, log_url).to_return(body: body)
      end

      context 'when the body does not match' do
        let(:body) { '' }

        its(:aggressive) { should be_nil }
      end

      context 'when the body matches' do
        after do
          expect(finder.aggressive).to eql WPScan::Model::DuplicatorInstallerLog.new(
            log_url,
            confidence: 100,
            found_by: described_class::DIRECT_ACCESS
          )
        end

        context 'when old versions of the file' do
          let(:body) { File.read(fixtures.join('old.txt')) }

          it 'returns the InterestingFinding' do
            # handled in after loop above
          end
        end

        context 'when newest versions of the file' do
          context 'when PRO format 1' do
            let(:body) { File.read(fixtures.join('pro.txt')) }

            it 'returns the InterestingFinding' do
              # handled in after loop above
            end
          end

          context 'when PRO format 2' do
            let(:body) { File.read(fixtures.join('pro2.txt')) }

            it 'returns the InterestingFinding' do
              # handled in after loop above
            end
          end

          context 'when LITE' do
            let(:body) { File.read(fixtures.join('lite.txt')) }

            it 'returns the InterestingFinding' do
              # handled in after loop above
            end
          end
        end
      end
    end
  end
end
