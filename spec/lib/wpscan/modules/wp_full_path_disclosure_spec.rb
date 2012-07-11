shared_examples_for "WpFullPathDisclosure" do

  before :all do
    @module = WpScanModuleSpec.new('http://example.localhost')
    @module.extend(WpFullPathDisclosure)

    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_full_path_disclosure'
  end

  describe "#full_path_disclosure_url" do
    it "should return http://example.localhost/wp-includes/rss-functions.php" do
      @module.full_path_disclosure_url.should === "http://example.localhost/wp-includes/rss-functions.php"
    end
  end

  describe "#has_full_path_disclosure?" do

    it "should return false on a 404" do
      stub_request(:get, @module.full_path_disclosure_url).
        to_return(:status => 404)

      @module.has_full_path_disclosure?.should be_false
    end

    it "should return false if no fpd found (blank page for example)" do
      stub_request(:get, @module.full_path_disclosure_url).
        to_return(:status => 200, :body => "")

      @module.has_full_path_disclosure?.should be_false
    end

    it "should return true" do
      stub_request(:get, @module.full_path_disclosure_url).
        to_return(:status => 200, :body => File.new(@fixtures_dir + '/rss-functions-disclosure.php'))

      @module.has_full_path_disclosure?.should be_true
    end
  end

end
