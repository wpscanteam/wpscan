# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::EmergencyPwdResetScript do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:file_url)   { url + 'emergency.php' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'emergency_pwd_reset_script') }

  before do
    expect(target).to receive(:sub_dir).at_least(1).and_return(false)
    expect(target).to receive(:head_or_get_params).and_return(method: :head)
  end

  describe '#aggressive' do
    context 'when not a 200' do
      it 'returns nil' do
        stub_request(:head, file_url).to_return(status: 404)

        expect(finder.aggressive).to eql nil
      end
    end

    context 'when 200 and matching the homepage' do
      before { stub_request(:head, file_url) }

      context 'when matching the homepage' do
        it 'returns nil' do
          stub_request(:get, file_url)

          expect(target).to receive(:homepage_or_404?).and_return(true)

          expect(finder.aggressive).to eql nil
        end
      end

      context 'when 200' do
        before do
          stub_request(:get, file_url).and_return(body: body)

          expect(target).to receive(:homepage_or_404?).and_return(false)
        end

        after do
          found = finder.aggressive

          expect(found).to eql WPScan::Model::EmergencyPwdResetScript.new(
            file_url,
            confidence: @expected_confidence,
            found_by: described_class::DIRECT_ACCESS
          )
        end

        context 'when body matches /password/' do
          let(:body) { File.read(fixtures.join('emergency.php')) }

          it 'returns with a confidence of 100' do
            @expected_confidence = 100
          end
        end

        context 'when body does not match /password/' do
          let(:body) { 'maybe, maybe not' }

          it 'returns with a confidence of 40' do
            @expected_confidence = 40
          end
        end
      end
    end
  end
end
