# frozen_string_literal: true

XMLRPC_FAILED_BODY = '
<?xml version="1.0" encoding="UTF-8"?>
<methodResponse>
  <fault>
    <value>
      <struct>
        <member>
          <name>faultCode</name>
          <value><int>405</int></value>
        </member>
        <member>
          <name>faultString</name>
          <value><string>%s</string></value>
        </member>
      </struct>
    </value>
  </fault>
</methodResponse>'

describe WPScan::Controller::PasswordAttack do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://ex.lo/' }
  let(:cli_args)       { "--url #{target_url}" }

  before do
    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
  end

  describe '#cli_options' do
    its(:cli_options) { should_not be_empty }
    its(:cli_options) { should be_a Array }

    it 'contains to correct options' do
      expect(controller.cli_options.map(&:to_sym))
        .to eq(%i[passwords usernames multicall_max_passwords password_attack login_uri])
    end
  end

  describe '#users' do
    context 'when no --usernames' do
      it 'calls target.users' do
        expect(controller.target).to receive(:users)
        controller.users
      end
    end

    context 'when --usernames' do
      let(:cli_args) { "#{super()} --usernames admin,editor" }

      it 'returns an array with the users' do
        expected = %w[admin editor].reduce([]) do |a, e|
          a << WPScan::Model::User.new(e)
        end

        expect(controller.users).to eql expected
      end
    end
  end

  describe '#run' do
    context 'when no --passwords is supplied' do
      it 'does not run the attacker' do
        expect(controller.run).to eql nil
      end
    end
  end

  describe '#xmlrpc_get_users_blogs_enabled?' do
    before { expect(controller.target).to receive(:xmlrpc).and_return(xmlrpc) }

    context 'when xmlrpc not found' do
      let(:xmlrpc) { nil }

      its(:xmlrpc_get_users_blogs_enabled?) { should be false }
    end

    context 'when xmlrpc not enabled' do
      let(:xmlrpc) { WPScan::Model::XMLRPC.new("#{target_url}xmlrpc.php") }

      it 'returns false' do
        expect(xmlrpc).to receive(:enabled?).and_return(false)

        expect(controller.xmlrpc_get_users_blogs_enabled?).to be false
      end
    end

    context 'when xmlrpc enabled' do
      let(:xmlrpc) { WPScan::Model::XMLRPC.new("#{target_url}xmlrpc.php") }

      before { expect(xmlrpc).to receive(:enabled?).and_return(true) }

      context 'when wp.getUsersBlogs methods not listed' do
        it 'returns false' do
          expect(xmlrpc).to receive(:available_methods).and_return(%w[m1 m2])

          expect(controller.xmlrpc_get_users_blogs_enabled?).to be false
        end
      end

      context 'when wp.getUsersBlogs method listed' do
        before do
          expect(xmlrpc).to receive(:available_methods).and_return(%w[wp.getUsersBlogs m2])

          stub_request(:post, xmlrpc.url).to_return(body: body)
        end

        context 'when wp.getUsersBlogs method disabled' do
          context 'when blog is in EN' do
            let(:body) { format(XMLRPC_FAILED_BODY, 'XML-RPC services are disabled on this site.') }

            it 'returns false' do
              expect(controller.xmlrpc_get_users_blogs_enabled?).to be false
            end
          end

          context 'when blog is in FR' do
            let(:body) { format(XMLRPC_FAILED_BODY, 'Les services XML-RPC sont désactivés sur ce site.') }

            it 'returns false' do
              expect(controller.xmlrpc_get_users_blogs_enabled?).to be false
            end
          end
        end

        context 'when wp.getUsersBlogs method enabled' do
          let(:body) { 'Incorrect username or password.' }

          it 'returns true' do
            expect(controller.xmlrpc_get_users_blogs_enabled?).to be true
          end
        end
      end
    end
  end

  describe '#attacker' do
    before do
      allow(controller.target).to receive(:sub_dir)
      controller.target.instance_variable_set(:@login_url, nil)
    end

    context 'when --password-attack provided' do
      let(:cli_args) { "#{super()} --password-attack #{attack}" }

      context 'when wp-login' do
        before { stub_request(:get, controller.target.url('wp-login.php')).to_return(status: status) }

        let(:attack) { 'wp-login' }

        context 'when available' do
          let(:status) { 200 }

          it 'returns the correct object' do
            expect(controller.attacker).to be_a WPScan::Finders::Passwords::WpLogin
            expect(controller.attacker.target).to be_a WPScan::Target
          end
        end

        context 'when not available (404)' do
          let(:status) { 404 }

          it 'raises an error' do
            expect { controller.attacker }.to raise_error(WPScan::Error::NoLoginInterfaceDetected)
          end
        end
      end

      context 'when xmlrpc' do
        context 'when xmlrpc not detected on target' do
          before do
            expect(controller.target).to receive(:xmlrpc).and_return(nil)
          end

          context 'when single xmlrpc' do
            let(:attack) { 'xmlrpc' }

            it 'raises an error' do
              expect { controller.attacker }.to raise_error(WPScan::Error::XMLRPCNotDetected)
            end
          end

          context 'when xmlrpc-multicall' do
            let(:attack) { 'xmlrpc-multicall' }

            it 'raises an error' do
              expect { controller.attacker }.to raise_error(WPScan::Error::XMLRPCNotDetected)
            end
          end
        end

        context 'when xmlrpc detected on target' do
          before do
            expect(controller.target)
              .to receive(:xmlrpc)
              .and_return(WPScan::Model::XMLRPC.new("#{target_url}xmlrpc.php"))
          end

          context 'when single xmlrpc' do
            let(:attack) { 'xmlrpc' }

            it 'returns the correct object' do
              expect(controller.attacker).to be_a WPScan::Finders::Passwords::XMLRPC
              expect(controller.attacker.target).to be_a WPScan::Model::XMLRPC
            end
          end

          context 'when xmlrpc-multicall' do
            let(:attack) { 'xmlrpc-multicall' }

            it 'returns the correct object' do
              expect(controller.attacker).to be_a WPScan::Finders::Passwords::XMLRPCMulticall
              expect(controller.attacker.target).to be_a WPScan::Model::XMLRPC
            end
          end
        end
      end
    end

    context 'when automatic detection' do
      context 'when xmlrpc_get_users_blogs_enabled? is false' do
        before do
          expect(controller).to receive(:xmlrpc_get_users_blogs_enabled?).and_return(false)
          stub_request(:get, controller.target.url('wp-login.php')).to_return(status: status)
        end

        context 'when wp-login available' do
          let(:status) { 200 }

          it 'returns the WpLogin' do
            expect(controller.attacker).to be_a WPScan::Finders::Passwords::WpLogin
            expect(controller.attacker.target).to be_a WPScan::Target
          end
        end

        context 'when wp-login.php not available' do
          let(:status) { 404 }

          it 'raises an error' do
            expect { controller.attacker }.to raise_error(WPScan::Error::NoLoginInterfaceDetected)
          end
        end
      end

      context 'when xmlrpc_get_users_blogs_enabled? is true' do
        before do
          expect(controller).to receive(:xmlrpc_get_users_blogs_enabled?).and_return(true)

          expect(controller.target)
            .to receive(:xmlrpc).and_return(WPScan::Model::XMLRPC.new("#{target_url}xmlrpc.php"))
        end

        context 'when WP version not found' do
          it 'returns the XMLRPC' do
            expect(controller.target).to receive(:wp_version).and_return(false)

            expect(controller.attacker).to be_a WPScan::Finders::Passwords::XMLRPC
            expect(controller.attacker.target).to be_a WPScan::Model::XMLRPC
          end
        end

        context 'when WP version found' do
          before { expect(controller.target).to receive(:wp_version).and_return(wp_version) }

          context 'when WP < 4.4' do
            let(:wp_version) { WPScan::Model::WpVersion.new('3.8.1') }

            it 'returns the XMLRPCMulticall' do
              expect(controller.attacker).to be_a WPScan::Finders::Passwords::XMLRPCMulticall
              expect(controller.attacker.target).to be_a WPScan::Model::XMLRPC
            end
          end

          context 'when WP >= 4.4' do
            let(:wp_version) { WPScan::Model::WpVersion.new('4.4') }

            it 'returns the XMLRPC' do
              expect(controller.attacker).to be_a WPScan::Finders::Passwords::XMLRPC
              expect(controller.attacker.target).to be_a WPScan::Model::XMLRPC
            end
          end
        end
      end
    end
  end
end
