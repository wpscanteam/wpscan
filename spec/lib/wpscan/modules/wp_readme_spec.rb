shared_examples_for "WpReadme" do

  before :all do
    @module       = WpScanModuleSpec.new('http://example.localhost')
    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_readme'

    @module.extend(WpReadme)
  end

  describe "#readme_url" do
    it "should return http://example.localhost/readme.html" do
      @module.readme_url.should === "#{@module.uri}/readme.html"
    end
  end

  describe "#has_readme?" do

    it "should return false on a 404" do
      stub_request(:get, @module.readme_url).
        to_return(:status => 404)

      @module.has_readme?.should be_false
    end

    it "should return true if it exists" do
      stub_request(:get, @module.readme_url).
        to_return(:status => 200, :body => File.new(@fixtures_dir + '/readme-3.2.1.html'))

      @module.has_readme?.should be_true
    end

    # http://code.google.com/p/wpscan/issues/detail?id=108
    it "should return true even if the readme.html is not in english" do
      stub_request(:get, @module.readme_url).
        to_return(:status => 200, :body => File.new(@fixtures_dir + '/readme-3.3.2-fr.html'))

      @module.has_readme?.should be_true
    end
  end

end
