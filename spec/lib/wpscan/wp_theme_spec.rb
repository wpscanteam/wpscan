require File.expand_path(File.dirname(__FILE__) + "/wpscan_helper")

describe WpTheme do

  before :all do
    @target_uri = URI.parse("http://example.localhost/")

    Browser.instance(
      :config_file   => SPEC_FIXTURES_CONF_DIR + "/browser/browser.conf.json",
      :cache_timeout => 0
    )
  end

  describe "#to_s" do
    it "should return the theme name and the version if there is one" do
      wp_theme = WpTheme.new("bueno", :version => "1.2.3")

      wp_theme.to_s.should === "bueno v1.2.3"
    end

    it "should not add the version if there is not" do
      style_url = @target_uri.merge("wp-content/themes/hello-world/style.css").to_s

      stub_request(:get, style_url).to_return(:status => 200, :body => "")

      wp_theme = WpTheme.new("hello-world", :style_url => style_url)

      wp_theme.to_s.should === "hello-world"
    end
  end

  describe "#find_from_css_link" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_THEME_DIR + "/find/css_link" }

    it "should return nil if no theme is present" do
      stub_request(:get, @target_uri.to_s).to_return(:status => 200, :body => "")

      WpTheme.find_from_css_link(@target_uri).should be_nil
    end

    it "should return a WpTheme object with .name = twentyeleven" do
      stub_request_to_fixture(:url => @target_uri.to_s, :fixture => fixtures_dir + "/wordpress-twentyeleven.htm")

      wp_theme = WpTheme.find_from_css_link(@target_uri)
      wp_theme.should be_a WpTheme
      wp_theme.name.should === "twentyeleven"
    end

    # http://code.google.com/p/wpscan/issues/detail?id=131
    # Theme name with spaces raises bad URI(is not URI?)
    it "should not raise an error if the theme name has spaces or special chars" do
      stub_request_to_fixture(:url => @target_uri.to_s, :fixture => fixtures_dir + "/theme-name-with-spaces.html")

      wp_theme = WpTheme.find_from_css_link(@target_uri)
      wp_theme.should be_a WpTheme
      wp_theme.name.should === "Copia di simplefolio"
    end

    it "should parse the url correctly" do
      stub_request_to_fixture(:url => @target_uri.to_s, :fixture => fixtures_dir + "/doctype.html")
      wp_theme = WpTheme.find_from_css_link(@target_uri)
      wp_theme.should be_a WpTheme
      wp_theme.style_url.should === "https://sub.example.com/start/app/wp-content/themes/rspectheme/style.css"
      wp_theme.name.should === "rspectheme"
    end
  end

  describe "#find_from_wooframework" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_THEME_DIR + "/find/wooframework" }

    after :each do
      stub_request_to_fixture(:url => @target_uri.to_s, :fixture => @fixture)

      wp_theme = WpTheme.find_from_wooframework(@target_uri)

      wp_theme.should be_a WpTheme unless wp_theme.nil?
      wp_theme.should === @expected_theme
    end

    it "should return a WpTheme object with .name 'Editorial' and .version '1.3.5'" do
      @fixture = fixtures_dir + "/editorial-1.3.5.html"
      @expected_theme = WpTheme.new("Editorial", :version => "1.3.5")
    end

    it "should return a WpTheme object with .name 'Merchant'" do
      @fixture = fixtures_dir + "/merchant-no-version.html"
      @expected_theme = WpTheme.new("Merchant")
    end
  end

  describe "#find" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_THEME_DIR + "/find" }

    after :each do
      stub_request_to_fixture(:url => @target_uri.to_s, :fixture => @fixture)

      wp_theme = WpTheme.find(@target_uri)

      if @expected_name
        wp_theme.should be_a WpTheme
        wp_theme.name.should === @expected_name
      else
        wp_theme.should be_nil
      end
    end

    it "should return nil if no theme is found" do
      @fixture  = SPEC_FIXTURES_DIR + "/empty-file"
      @expected_name = nil
    end

    it "should return a WpTheme object with .name 'twentyeleven'" do
      @fixture = fixtures_dir + "/css_link/wordpress-twentyeleven.htm"
      @expected_name = "twentyeleven"
    end

    it "should a WpTheme object with .name 'Merchant'" do
      @fixture = fixtures_dir + "/wooframework/merchant-no-version.html"
      @expected_name = "Merchant"
    end
  end

  describe "#version" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_THEME_DIR + "/version" }
    let(:theme_style_url) { @target_uri.merge("wp-content/themes/spec-theme/style.css").to_s }

    after :each do
      if @fixture
        stub_request_to_fixture(:url => theme_style_url, :fixture => @fixture)

        wp_theme = WpTheme.new('spec-theme', :style_url => theme_style_url)

        wp_theme.version.should === @expected
      end
    end

    it "should return nil if the version is not found" do
      @fixture  = fixtures_dir + "/twentyeleven-unknow.css"
      @expected = nil
    end

    it "should return nil if the style_url is nil" do
      WpTheme.new("hello-world").version.should be_nil
    end

    it "should return 1.3" do
      @fixture  = fixtures_dir + "/twentyeleven-1.3.css"
      @expected = "1.3"
    end

    it "should return 1.5.1" do
      @fixture  = fixtures_dir + "/bueno-1.5.1.css"
      @expected = "1.5.1"
    end
  end

end
