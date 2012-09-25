#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

shared_examples_for "WpLoginProtection" do

  before :each do
    @module = WpScanModuleSpec.new('http://example.localhost')
    @module.extend(WpLoginProtection)

    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_login_protection'
  end

  describe "#login_url" do
    it "should return the login page url : http://example.localhost/wp-login.php" do
      @module.login_url.should === "http://example.localhost/wp-login.php"
    end
  end

  # It will test all protected methods has_.*_protection with each fixtures to be sure that
  # there is not false positive : for example the login-lock must not be detected as login-lockdown
  describe "#has_.*_protection?" do

    pattern = WpLoginProtection::LOGIN_PROTECTION_METHOD_PATTERN
    fixtures =
        %w{
            wp-login-clean.php wp-login-login_lockdown.php wp-login-login_lock.php
            wp-login-better_wp_security.php wp-login-simple_login_lockdown.php wp-login-login_security_solution.php
            wp-login-limit_login_attempts.php wp-login-bluetrait_event_viewer.php
        }
    # For plugins which are detected from the existence of their directory into wp-content/plugins/ (or one of their file)
    # and not from a regex into the login page
    special_plugins = %w{better_wp_security simple_login_lockdown login_security_solution limit_login_attempts bluetrait_event_viewer}

    after :each do
      stub_request_to_fixture(:url => @module.login_url, :fixture => @fixture)

      # Stub all special plugins urls to a 404 except if it's the one we want
      special_plugins.each do |special_plugin|
        special_plugin_call_detection_symbol = :"has_#{special_plugin}_protection?"
        special_plugin_call_url_symbol = :"#{special_plugin}_url"

        status_code = (@symbol_to_call === special_plugin_call_detection_symbol and @expected === true) ? 200 : 404
        stub_request(:get, @module.send(special_plugin_call_url_symbol).to_s).to_return(:status => status_code)
      end

      @module.send(@symbol_to_call).should === @expected
    end

    WpLoginProtection.protected_instance_methods.grep(pattern).each do |symbol_to_call|
      plugin_name_from_symbol = symbol_to_call[pattern, 1].gsub('_', '-')

      fixtures.each do |fixture|
        plugin_name_from_fixture = fixture[/wp-login-(.*)\.php/i, 1].gsub('_', '-')
        expected = plugin_name_from_fixture === plugin_name_from_symbol ? true : false

        it "#{symbol_to_call} with #{fixture} should return #{expected}" do
          @plugin_name = plugin_name_from_fixture
          @fixture = @fixtures_dir + '/' + fixture
          @symbol_to_call = symbol_to_call
          @expected = expected
        end
      end
    end
  end

  # Factorise this with the code above ? :D
  describe "#login_protection_plugin" do
    after :each do
      stub_request_to_fixture(:url => @module.login_url, :fixture => @fixture)
      stub_request(:get, @module.send(:better_wp_security_url).to_s).to_return(:status => 404)
      stub_request(:get, @module.send(:simple_login_lockdown_url).to_s).to_return(:status => 404)
      stub_request(:get, @module.send(:login_security_solution_url).to_s).to_return(:status => 404)
      stub_request(:get, @module.send(:limit_login_attempts_url).to_s).to_return(:status => 404)
      stub_request(:get, @module.send(:bluetrait_event_viewer_url).to_s).to_return(:status => 404)

      @module.login_protection_plugin().should === @plugin_expected
      @module.has_login_protection?.should === @has_protection_expected
    end

    it "should return nil if no protection is present" do
      @fixture = @fixtures_dir + "/wp-login-clean.php"
      @plugin_expected = nil
      @has_protection_expected = false
    end

    it "should return a login-lockdown WpPlugin object" do
      @fixture = @fixtures_dir + "/wp-login-login_lockdown.php"
      @plugin_expected = WpPlugin.new(:base_url => @module.url,
                                      :path => "/plugins/login-lockdown/",
                                      :name => "login-lockdown"
      )
      @has_protection_expected = true
    end

    it "should return a login-lock WpPlugin object" do
      @fixture = @fixtures_dir + "/wp-login-login_lock.php"
      @plugin_expected = WpPlugin.new(:base_url => @module.url,
                                      :path => "/plugins/login-lock/",
                                      :name => "login-lock"
      )
      @has_protection_expected = true
    end
  end

end
