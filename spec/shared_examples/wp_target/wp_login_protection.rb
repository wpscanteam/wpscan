# encoding: UTF-8

shared_examples 'WpTarget::WpLoginProtection' do

  let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + '/wp_login_protection' }

  before { allow(wp_target).to receive(:wp_plugins_dir).and_return('wp-content/plugins') }

  # It will test all protected methods has_.*_protection with each fixtures to be sure that
  # there is not false positive : for example the login-lock must not be detected as login-lockdown
  describe '#has_.*_protection?' do

    pattern = WpTarget::WpLoginProtection::LOGIN_PROTECTION_METHOD_PATTERN
    fixtures = %w(
      wp-login-clean.php wp-login-login_lockdown.php wp-login-login_lock.php
      wp-login-better_wp_security.php wp-login-simple_login_lockdown.php
      wp-login-login_security_solution.php wp-login-limit_login_attempts.php
      wp-login-bluetrait_event_viewer.php wp-login-security_protection.php
    )

    # For plugins which are detected from the existence of their directory into wp-content/plugins/ (or one of their file)
    # and not from a regex into the login page
    special_plugins = %w(better_wp_security simple_login_lockdown login_security_solution limit_login_attempts bluetrait_event_viewer)

    after :each do
      stub_request_to_fixture(url: login_url, fixture: @fixture)

      # Stub all special plugins urls to a 404 except if it's the one we want
      special_plugins.each do |special_plugin|
        special_plugin_call_detection_symbol = :"has_#{special_plugin}_protection?"
        special_plugin_call_url_symbol = :"#{special_plugin}_url"

        status_code = (@symbol_to_call === special_plugin_call_detection_symbol and @expected === true) ? 200 : 404
        stub_request(:get, wp_target.send(special_plugin_call_url_symbol).to_s).to_return(status: status_code)
      end

      expect(wp_target.send(@symbol_to_call)).to eql @expected
    end

    protected_instance_methods.grep(pattern).each do |symbol_to_call|
      plugin_name_from_symbol = symbol_to_call[pattern, 1].gsub('_', '-')

      fixtures.each do |fixture|
        plugin_name_from_fixture = fixture[/wp-login-(.*)\.php/i, 1].gsub('_', '-')
        expected = plugin_name_from_fixture === plugin_name_from_symbol ? true : false

        it "#{symbol_to_call} with #{fixture} returns #{expected}" do
          @plugin_name    = plugin_name_from_fixture
          @fixture        = File.join(fixtures_dir, fixture)
          @symbol_to_call = symbol_to_call
          @expected       = expected
        end
      end
    end
  end

  describe '#login_protection_plugin' do
    after :each do
      stub_request(:get, /.*/).to_return(status: 404)
      stub_request_to_fixture(url: login_url, fixture: @fixture)

      expect(wp_target.login_protection_plugin).to eq @plugin_expected
      expect(wp_target.has_login_protection?).to eql @protection_expected
    end

    it 'returns nil if no protection is present' do
      @fixture             = File.join(fixtures_dir, 'wp-login-clean.php')
      @plugin_expected     = nil
      @protection_expected = false
    end

    it 'returns a login-lockdown WpPlugin object' do
      @fixture             = File.join(fixtures_dir, 'wp-login-login_lockdown.php')
      @plugin_expected     = WpPlugin.new(wp_target.uri, name: 'login-lockdown')
      @protection_expected = true
    end

    it 'returns a login-lock WpPlugin object' do
      @fixture             = File.join(fixtures_dir, 'wp-login-login_lock.php')
      @plugin_expected     = WpPlugin.new(wp_target.uri, name: 'login-lock')
      @protection_expected = true
    end

    it 'returns a security-protection WpPlugin object' do
      @fixture             = File.join(fixtures_dir, 'wp-login-security_protection.php')
      @plugin_expected     = WpPlugin.new(wp_target.uri, name: 'security-protection')
      @protection_expected = true
    end
  end

end
