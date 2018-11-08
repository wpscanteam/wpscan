require 'spec_helper'

describe WPScan::Finders::Users::WpJsonApi do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'users', 'wp_json_api') }

  describe '#aggressive' do
    before do
      allow(target).to receive(:sub_dir).and_return(false)
      stub_request(:get, finder.api_url).to_return(body: body)
    end

    context 'when not a JSON response' do
      let(:body) { '' }

      its(:aggressive) { should eql([]) }
    end

    context 'when a JSON response' do
      context 'when unauthorised' do
        let(:body) { File.read(File.join(fixtures, '401.json')) }

        its(:aggressive) { should eql([]) }
      end

      context 'when limited exposure (WP >= 4.7.1)' do
        let(:body) { File.read(File.join(fixtures, '4.7.2.json')) }

        it 'returns the expected array of users' do
          users = finder.aggressive

          expect(users.size).to eql 1

          user = users.first

          expect(user.id).to eql 1
          expect(user.username).to eql 'admin'
          expect(user.confidence).to eql 100
          expect(user.interesting_entries).to eql ['http://wp.lab/wp-json/wp/v2/users/']
        end
      end
    end
  end
end
