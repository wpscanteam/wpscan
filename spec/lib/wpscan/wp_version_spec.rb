require File.expand_path(File.dirname(__FILE__) + '/wpscan_helper')

describe WpVersion do

  before :all do
    @target_uri  = URI.parse('http://example.localhost/')
    @browser     = Browser.instance(:config_file => SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json')
  end

  describe "#find_from_meta_generator" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/meta-generator" }

    after :each do
      stub_request_to_fixture(:url => @target_uri.to_s, :fixture => @fixture)

      WpVersion.find_from_meta_generator(@target_uri.to_s).should === @expected
    end

    it "should return nil if the meta-generator is not found" do
      @fixture  = fixtures_dir + "/no-meta-generator.htm"
      @expected = nil
    end

    it "should return 3.3.2" do
      @fixture  = fixtures_dir + "/3.3.2.htm"
      @expected = "3.3.2"
    end

    it "should return 3.4-beta4" do
      @fixture  = fixtures_dir + "/3.4-beta4.htm"
      @expected = "3.4-beta4"
    end
  end

  describe "#find_from_rss_generator" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/rss-generator" }

    after :each do
      @status_code ||= 200
      stub_request_to_fixture(:url => @target_uri.merge("feed/").to_s, :status => @status_code, :fixture => @fixture)

      WpVersion.find_from_rss_generator(@target_uri).should === @expected
    end

    it "should return nil on a 404" do
      @status_code = 404
      @fixture  = SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/404.htm"
      @expected = nil
    end

    it "should return nil if the rss-generator is not found" do
      @fixture  = fixtures_dir + "/no-rss-generator.htm"
      @expected = nil
    end

    it "should return nil if the version is not found (but the rss-generator is present)" do
      @fixture  = fixtures_dir + "/no-version.htm"
      @expected = nil
    end

    it "shuld return 3.3.2" do
      @fixture  = fixtures_dir + "/3.3.2.htm"
      @expected = "3.3.2"
    end

    it "should return 3.4-beta4" do
      @fixture  = fixtures_dir + "/3.4-beta4.htm"
      @expected = "3.4-beta4"
    end
  end

  describe "#find_from_sitemap_generator" do
    after :each do
      stub_request(:get, @target_uri.merge("sitemap.xml").to_s).
        to_return(:status => 200, :body => @body)

        WpVersion.find_from_sitemap_generator(@target_uri).should === @expected
      end

    it "should return nil if the generator is not found" do
      @body     = ''
      @expected = nil
    end

    it "should return the version : 3.3.2" do
      @body     = "<!-- generator=\"wordpress/3.3.2\" -->"
      @expected = "3.3.2"
    end

    it "should return nil if it's not a valid version, must contains at least one '.'" do
      @body     = "<!-- generator=\"wordpress/5065\" -->"
      @expected = nil
    end
  end

  describe "#find_from_readme" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + '/readme' }

    after :each do
      @status_code ||= 200
      stub_request_to_fixture(:url => @target_uri.merge("readme.html").to_s, :status => @status_code, :fixture => @fixture)

      WpVersion.find_from_readme(@target_uri).should === @expected
    end

    it "should return nil on a 404" do
      @status_code = 404
      @fixture     = SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/404.htm"
      @expected    = nil
    end

    it "should return nil if the version number is not present" do
      @fixture  = fixtures_dir + "/empty-version.html"
      @expected = nil
    end

    it "should return 3.3.2" do
      @fixture  = fixtures_dir + "/readme-3.3.2.html"
      @expected = "3.3.2"
    end
  end

end
