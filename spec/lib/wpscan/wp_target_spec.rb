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

require File.expand_path(File.dirname(__FILE__) + '/wpscan_helper')

describe WpTarget do

  before :each do
    Browser.reset
    @options =
    {
      :config_file    => SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json',
      :cache_timeout  => 0,
      :wp_content_dir => "wp-content",
      :wp_plugins_dir => "wp-content/plugins"
    }
    @wp_target = WpTarget.new("http://example.localhost/", @options)
  end

  it_should_behave_like "WebSite"
  it_should_behave_like "WpReadme"
  it_should_behave_like "WpConfigBackup"
  it_should_behave_like "WpFullPathDisclosure"
  it_should_behave_like "WpLoginProtection"
  it_should_behave_like "Malwares"
  it_should_behave_like "BruteForce"
  it_should_behave_like "WpUsernames"
  it_should_behave_like "WpTimthumbs"
  it_should_behave_like "WpPlugins"
  it_should_behave_like "WpThemes"

  describe "#initialize" do
    it "should raise an error if the target_url is nil or empty" do
      expect { WpTarget.new(nil) }.to raise_error
      expect { Wptarget.new('') }.to raise_error
    end

    it "should add the http protocol if missing" do
      WpTarget.new("example.localhost/", @options).url.should === "http://example.localhost/"
    end

    it "should add the trailing slash to the url if missing" do
      WpTarget.new("lamp/wordpress", @options).url.should === "http://lamp/wordpress/"
    end
  end

  describe "#url" do
    it "should return the url of the target" do
      @wp_target.url.should === @wp_target.uri.to_s
    end
  end

  describe "#login_url" do
    let(:login_url) { @wp_target.uri.merge("wp-login.php").to_s }

    it "should return the login url of the target" do
      stub_request(:get, login_url).to_return(:status => 200, :body => '')

      @wp_target.login_url.should === login_url
    end

    it "should return the redirection url if there is one (ie: for https)" do
      https_login_url = login_url.gsub(/^http:/, "https:")

      stub_request(:get, login_url).to_return(:status => 302, :headers => {:location => https_login_url})

      @wp_target.login_url.should === https_login_url
    end
  end

  describe "#error_404_hash" do
    it "should return the md5sum of the 404 page" do
      stub_request(:any, /.*/).
        to_return(:status => 404, :body => "404 page !")

      @wp_target.error_404_hash.should === Digest::MD5.hexdigest("404 page !")
    end
  end

  describe "#wp_content_dir" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + "/wp_content_dir" }

    after :each do
      @wp_target = WpTarget.new(@target_url) if @target_url
      stub_request_to_fixture(:url => @wp_target.url, :fixture => @fixture) if @fixture

      @wp_target.wp_content_dir.should === @expected
    end

    it "should return the string set in the initialize method" do
      @wp_target = WpTarget.new("http://example.localhost/", :wp_content_dir => "hello-world")
      @expected  = "hello-world"
    end

    it "should return 'wp-content'" do
      @target_url = "http://lamp/wordpress-3.4.1"
      @fixture    = fixtures_dir + "/wordpress-3.4.1.htm"
      @expected   = "wp-content"
    end

    it "should find the default 'wp-content' dir even if the target_url is not the same (ie : the user supply an IP address and the url used in the code is a domain)" do
      @target_url = "http://192.168.1.103/wordpress-3.4.1/"
      @fixture    = fixtures_dir + "/wordpress-3.4.1.htm"
      @expected   = "wp-content"
    end

    it "should return 'custom-content'" do
      @target_url = "http://lamp/wordpress-3.4.1-custom"
      @fixture    = fixtures_dir + "/wordpress-3.4.1-custom.htm"
      @expected   = "custom-content"
    end

    it "should return 'custom content spaces'" do
      @target_url = "http://lamp/wordpress-3.4.1-custom"
      @fixture    = fixtures_dir + "/wordpress-3.4.1-custom-with-spaces.htm"
      @expected   = "custom content spaces"
    end

    it "should return 'custom-dir/subdir/content'" do
      @target_url = "http://lamp/wordpress-3.4.1-custom"
      @fixture    = fixtures_dir + "/wordpress-3.4.1-custom-subdirectories.htm"
      @expected   = "custom-dir/subdir/content"
    end

    it "should also check in src attributes" do
      @target_url = "http://lamp/wordpress-3.4.1"
      @fixture    = fixtures_dir + "/wordpress-3.4.1-in-src.htm"
      @expected   = "wp-content"
    end

    it "should find the location even if the src or href goes in the plugins dir" do
      @target_url = "http://wordpress-3.4.1-in-plugins.htm"
      @fixture    = fixtures_dir + "/wordpress-3.4.1-in-plugins.htm"
      @expected   = "wp-content"
    end

  end

  describe "#wp_plugins_dir" do
    after :each do
      @wp_target.stub(:wp_plugins_dir => @stub_value) if @stub_value

      @wp_target.wp_plugins_dir.should === @expected
    end

    it "should return the string set in the initialize method" do
      @wp_target = WpTarget.new("http://example.localhost/", :wp_content_dir => "asdf", :wp_plugins_dir => "custom-plugins")
      @expected  = "custom-plugins"
    end

    it "should return 'plugins'" do
      @stub_value = "plugins"
      @expected   = "plugins"
    end

    it "should return 'wp-content/plugins'" do
      @stub_value = nil
      @expected   = "wp-content/plugins"
    end
  end

  describe "#wp_plugins_dir_exists?" do
    it "should return true" do
      target = WpTarget.new("http://example.localhost/", :wp_content_dir => "asdf", :wp_plugins_dir => "custom-plugins")
      url = target.uri.merge(target.wp_plugins_dir).to_s
      stub_request(:any, url).to_return(:status => 200)
      target.wp_plugins_dir_exists?.should == true
    end

    it "should return false" do
      target = WpTarget.new("http://example.localhost/", :wp_content_dir => "asdf", :wp_plugins_dir => "custom-plugins")
      url = target.uri.merge(target.wp_plugins_dir).to_s
      stub_request(:any, url).to_return(:status => 404)
      target.wp_plugins_dir_exists?.should == false
    end
  end

  describe "#debug_log_url" do
    it "should return 'http://example.localhost/wp-content/debug.log" do
      @wp_target.stub(:wp_content_dir => "wp-content")
      @wp_target.debug_log_url.should === "http://example.localhost/wp-content/debug.log"
    end
  end

  describe "#has_debug_log?" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + "/debug_log" }

    after :each do
      @wp_target.stub(:wp_content_dir => "wp-content")
      stub_request_to_fixture(:url => @wp_target.debug_log_url(), :fixture => @fixture)
      @wp_target.has_debug_log?.should === @expected
    end

    it "should return false" do
      @fixture  = SPEC_FIXTURES_DIR + "/empty-file"
      @expected = false
    end

    it "should return true" do
      @fixture  = fixtures_dir + "/debug.log"
      @expected = true
    end

    it "should also detect it if there are PHP notice" do
      @fixture = fixtures_dir + "/debug-notice.log"
      @expected = true
    end
  end

  describe "#search_replace_db_2_url" do
    it "should return the correct url" do
      @wp_target.search_replace_db_2_url.should == "http://example.localhost/searchreplacedb2.php"
    end
  end

  describe "#search_replace_db_2_exists?" do
    it "should return true" do
      stub_request(:any, @wp_target.search_replace_db_2_url).to_return(:status => 200, :body => "asdf by interconnect asdf")
      @wp_target.search_replace_db_2_exists?.should be_true
    end

    it "should return false" do
      stub_request(:any, @wp_target.search_replace_db_2_url).to_return(:status => 500)
      @wp_target.search_replace_db_2_exists?.should be_false
    end

    it "should return false" do
      stub_request(:any, @wp_target.search_replace_db_2_url).to_return(:status => 500, :body => "asdf by interconnect asdf")
      @wp_target.search_replace_db_2_exists?.should be_false
    end
  end

  describe "#registration_url" do
    it "should return the correct url (multisite)" do
      # set to multi site
      stub_request(:any, "http://example.localhost/wp-signup.php").to_return(:status => 200)
      @wp_target.registration_url.to_s.should == "http://example.localhost/wp-signup.php"
    end

    it "should return the correct url (not multisite)" do
      # set to single site
      stub_request(:any, "http://example.localhost/wp-signup.php").to_return(:status => 302, :headers => { "Location" => "wp-login.php?action=register" })
      @wp_target.registration_url.to_s.should == "http://example.localhost/wp-login.php?action=register"
    end
  end

  describe "#registration_enabled?" do
    it "should return false (multisite)" do
      # set to multi site
      stub_request(:any, "http://example.localhost/wp-signup.php").to_return(:status => 200)
      stub_request(:any, @wp_target.registration_url.to_s).to_return(:status => 302, :headers => { "Location" => "wp-login.php?registration=disabled" })
      @wp_target.registration_enabled?.should be_false
    end

    it "should return true (multisite)" do
      # set to multi site
      stub_request(:any, "http://example.localhost/wp-signup.php").to_return(:status => 200)
      stub_request(:any, @wp_target.registration_url.to_s).to_return(:status => 200, :body => %{<form id="setupform" method="post" action="wp-signup.php">})
      @wp_target.registration_enabled?.should be_true
    end

    it "should return false (not multisite)" do
      # set to single site
      stub_request(:any, "http://example.localhost/wp-signup.php").to_return(:status => 302, :headers => { "Location" => "wp-login.php?action=register" })
      stub_request(:any, @wp_target.registration_url.to_s).to_return(:status => 302, :headers => { "Location" => "wp-login.php?registration=disabled" })
      @wp_target.registration_enabled?.should be_false
    end

    it "should return true (not multisite)" do
      # set to single site
      stub_request(:any, "http://example.localhost/wp-signup.php").to_return(:status => 302, :headers => { "Location" => "wp-login.php?action=register" })
      stub_request(:any, @wp_target.registration_url.to_s).to_return(:status => 200, :body => %{<form name="registerform" id="registerform" action="wp-login.php"})
      @wp_target.registration_enabled?.should be_true
    end

    it "should return false" do
      # set to single site
      stub_request(:any, "http://example.localhost/wp-signup.php").to_return(:status => 302, :headers => { "Location" => "wp-login.php?action=register" })
      stub_request(:any, @wp_target.registration_url.to_s).to_return(:status => 500)
      @wp_target.registration_enabled?.should be_false
    end
  end

  describe "#is_multisite?" do
    before :each do
      @url = @wp_target.uri.merge("wp-signup.php").to_s
    end

    it "should return false" do
      stub_request(:any, @url).to_return(:status => 302, :headers => { "Location" => "wp-login.php?action=register" })
      @wp_target.is_multisite?.should be_false
    end

    it "should return true" do
      stub_request(:any, @url).to_return(:status => 302, :headers => { "Location" => "http://example.localhost/wp-signup.php" })
      @wp_target.is_multisite?.should be_true
    end

    it "should return true" do
      stub_request(:any, @url).to_return(:status => 200)
      @wp_target.is_multisite?.should be_true
    end

    it "should return false" do
      stub_request(:any, @url).to_return(:status => 500)
      @wp_target.is_multisite?.should be_false
    end
  end
end
