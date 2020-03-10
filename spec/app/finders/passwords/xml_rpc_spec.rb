# frozen_string_literal: true

describe WPScan::Finders::Passwords::XMLRPC do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Model::XMLRPC.new(url) }
  let(:url)        { 'http://ex.lo/xmlrpc.php' }

  RESPONSE_403_BODY = '<?xml version="1.0" encoding="UTF-8"?>
    <methodResponse>
      <fault>
        <value>
          <struct>
            <member>
              <name>faultCode</name>
              <value><int>403</int></value>
            </member>
            <member>
              <name>faultString</name>
              <value><string>Incorrect username or password.</string></value>
            </member>
          </struct>
        </value>
      </fault>
    </methodResponse>'

  describe '#attack' do
    context 'when no valid credentials' do
      before do
        stub_request(:post, url).to_return(status: status, body: RESPONSE_403_BODY)

        finder.attack(users, %w[pwd])
      end

      let(:users) { %w[admin].map { |username| WPScan::Model::User.new(username) } }

      context 'when status = 200' do
        let(:status) { 200 }

        its('progress_bar.log') { should be_empty }
      end

      context 'when status = 403' do
        let(:status) { 403 }

        its('progress_bar.log') { should be_empty }
      end
    end
  end
end
