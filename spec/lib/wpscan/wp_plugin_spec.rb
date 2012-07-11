require File.expand_path(File.dirname(__FILE__) + '/wpscan_helper')

describe WpPlugin do

  before :all do
    @browser = Browser.instance(:config_file => SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json')
  end

  describe "#location_uri_from_url" do
    after :each do
      if @url
        uri = WpPlugin.location_uri_from_url(@url)

        uri.should be_a URI
        uri.to_s.should === @expected_uri_string
      end
    end

    #it "should raise an error if the url is not valid" do
    #  expect { WpPlugin.location_uri_from_url("example.com") }.to raise_error
    #  expect { WpPlugin.location_uri_from_url("http://example.com/wp-includes/plugins/example/") }.to raise_error
    #end

    it "should return the uri without the file" do
      @url                 = "http://example.com/wp-content/plugins/example/readme.txt"
      @expected_uri_string = "http://example.com/wp-content/plugins/example/"
    end

    it "should return the same uri" do
      @url                 = "http://example.com/wp-content/plugins/hello-world/"
      @expected_uri_string = @url
    end

    # http://code.google.com/p/wpscan/issues/detail?id=146
    it "should not raise an error if the url uses https" do
      @url                 = "https://example.com/folder1/folder2/wp-content/plugins/user-role-editor/index.php"
      @expected_uri_string = "https://example.com/folder1/folder2/wp-content/plugins/user-role-editor/"
    end

    it "should add the last slash if it's not present" do
      @url                 = "http://example.com/wp-content/plugins/test-one"
      @expected_uri_string = "#{@url}/"
    end
  end

  describe "#extract_name_from_location_url" do
    it "should return 'example-plugin'" do
      WpPlugin.extract_name_from_location_url('http://example.com/wp-content/plugins/example-plugin/').should === 'example-plugin'
    end
  end

  describe "#create_location_url_from_name" do
    after :each do
      WpPlugin.create_location_url_from_name(@plugin_name, @target_url).should === @expected_url
    end

    it "should return 'http://example.com/$wp-plugins$/example/'" do
      @plugin_name  = "example"
      @target_url   = "http://example.com/"
      @expected_url = "http://example.com/$wp-plugins$/example/"
    end

    it "should return 'http://example.com/$wp-plugins$/example/' even if the last '/' is not in the target url" do
      @plugin_name  = "example"
      @target_url   = "http://example.com"
      @expected_url = "http://example.com/$wp-plugins$/example/"
    end

    it "should return http://example.com/$wp-plugins$/example-test/" do
      @plugin_name  = "example-test"
      @target_url   = "http://example.com"
      @expected_url = "http://example.com/$wp-plugins$/example-test/"
    end

    it "should return http://example.com/$wp-plugins$/something%20with%20spaces/" do
      @plugin_name  = "something with spaces"
      @target_url   = "http://example.com"
      @expected_url = URI.escape("http://example.com/$wp-plugins$/something with spaces/")
    end
  end

  describe "#create_url_from_raw" do
    it "should return http://example.com/$wp-plugins$/example-test/readme.txt" do
      WpPlugin.create_url_from_raw("example-test/readme.txt", URI.parse("http://example.com")).should === "http://example.com/$wp-plugins$/example-test/readme.txt"
    end
  end

  describe "#initialize" do
    let(:location_url) { 'http://example.com/wp-content/plugins/example/' }

    it "should raise an exception" do
      expect { WpPlugin.new('invalid location url') }.to raise_error
    end

    it "should initialize the object (no options given), :name should be 'example'" do
      wp_plugin = WpPlugin.new(location_url)
      wp_plugin.name.should === 'example'
      wp_plugin.location_url.should === location_url
    end

    it "should initialize the object (options[:name] = 'example')" do
      wp_plugin = WpPlugin.new(location_url, :name => 'example')
      wp_plugin.name.should === 'example'
      wp_plugin.location_url.should === location_url
    end
  end

  # TODO
  describe "operators : ==, ===, <=>" do

  end

  #TODO
  describe "#location_url" do

  end

  describe "#version" do
    let(:location_url) { 'http://example.localhost/wp-content/plugins/simple-login-lockdown/' }
    let(:wp_plugin) { WpPlugin.new(location_url) }
    let(:readme_url) { 'http://example.localhost/wp-content/plugins/simple-login-lockdown/readme.txt' }
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR + '/version' }

    it "should return nil if the readme.txt does not exist" do
      stub_request(:get, readme_url).
        to_return(:status => 404)

      wp_plugin.version.should be_nil
    end

    it "should return nil if the version is invalid (IE : trunk etc)" do
      stub_request(:get, readme_url).
        to_return(:status => 200, :body => File.new(fixtures_dir + '/trunk-version.txt'))

      wp_plugin.version.should be_nil
    end

    it "should return the version 0.4" do
      stub_request(:get, readme_url).
        to_return(:status => 200, :body => File.new(fixtures_dir + '/simple-login-lockdown-0.4.txt'))

      wp_plugin.version.should === '0.4'
    end
  end

  describe "#vulnerabilities" do
    let(:location_url) { 'http://example.localhost/wp-content/plugins/spec-plugin/' }
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR + '/vulnerabilities' }
    let(:vulns_xml) { fixtures_dir + '/plugin_vulns.xml' }
    let(:wp_plugin) { WpPlugin.new(location_url, :vulns_xml => vulns_xml) }


    it "should return an empty array when no vulnerabilities are found" do
      WpPlugin.new(
        'http://example.localhost/wp-content/plugins/no-vulns/',
        :vulns_xml => vulns_xml
      ).vulnerabilities.should be_empty
    end

    it "should return an arry with 2 vulnerabilities" do
      vulnerabilities = wp_plugin.vulnerabilities

      vulnerabilities.should_not be_empty
      vulnerabilities.length.should == 2
      vulnerabilities.each { |vulnerability| vulnerability.should be_a WpVulnerability }
      vulnerabilities[0].title.should === 'WPScan Spec'
      vulnerabilities[1].title.should === 'Spec SQL Injection'
    end
  end

  describe "#error_log* (#error_log_url & #error_log?)" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR + '/error_log' }
    let(:location_url) { 'http://example.localhost/wp-content/plugins/simple-login-lockdown/' }
    let(:error_log_url) { 'http://example.localhost/wp-content/plugins/simple-login-lockdown/error_log' }
    let(:wp_plugin) { WpPlugin.new(location_url) }

    it "should return the url of the error log" do
      wp_plugin.error_log_url.should === error_log_url
    end

    it "should return false on a 404" do
      stub_request(:get, error_log_url).
        to_return(:status => 404)

      wp_plugin.error_log?.should be_false
    end

    it "should return true" do
      stub_request(:get, error_log_url).
        to_return(:status => 200, :body => File.new(fixtures_dir + '/error_log'))

      wp_plugin.error_log?.should be_true
    end
  end

  describe "#directory_listing?" do
    let(:wp_plugin) { WpPlugin.new('http://example.localhost/wp-content/plugins/simple-login-lockdown/readme.txt') }

    it "should return false on a 404" do
      stub_request(:get, wp_plugin.location_url).to_return(:status => 404)

      wp_plugin.directory_listing?.should be_false
    end

    it "should return false on a blank page" do
      stub_request(:get, wp_plugin.location_url).to_return(:status => 200, :body => '')

      wp_plugin.directory_listing?.should be_false
    end

    it "should return true" do
      stub_request(:get, wp_plugin.location_url).
        to_return(:status => 200, :body => "<title>Index of simple-login-lockdown</title>")

      wp_plugin.directory_listing?.should be_true
    end
  end
end
