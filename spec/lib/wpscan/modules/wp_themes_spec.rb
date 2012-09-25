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

shared_examples_for "WpThemes" do

  before :all do
    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_themes'
    @themes_file = @fixtures_dir + "/themes.txt"
    @theme_vulns_file = @fixtures_dir + "/theme_vulns.xml"

    @wp_url = "http://example.localhost/"
  end

  before :each do
    @module = WpScanModuleSpec.new(@wp_url)
    @module.error_404_hash = Digest::MD5.hexdigest("Error 404!")
    @module.extend(WpThemes)

    @options = {:base_url => @wp_url,
                :only_vulnerable_ones => false,
                :show_progress_bar => false,
                :error_404_hash => Digest::MD5.hexdigest("Error 404!"),
                :vulns_file => @theme_vulns_file,
                :file => @themes_file,
                :type => "themes",
                :wp_content_dir => "wp-content",
                :vulns_xpath_2 => "//theme"
    }
    File.exist?(@theme_vulns_file).should == true
    File.exist?(@themes_file).should == true
    @targets = [WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zenpro/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zenpro"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zeta-zip/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zeta-zip"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zfirst/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zfirst"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zgrey/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zgrey"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zindi-ii/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zindi-ii"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zindi/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zindi"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zombie-apocalypse/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zombie-apocalypse"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zsofa/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zsofa"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "zwei-seiten/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "zwei-seiten"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "twentyten/404.php",
                             :wp_content_dir => "wp-content",
                             :name => "twentyten"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "shopperpress",
                             :wp_content_dir => "wp-content",
                             :name => "shopperpress"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "wise",
                             :wp_content_dir => "wp-content",
                             :name => "wise"}),
                WpTheme.new({:base_url => "http://example.localhost/",
                             :path => "webfolio",
                             :wp_content_dir => "wp-content",
                             :name => "webfolio"})]
  end

  describe "#themes_from_passive_detection" do
    let(:passive_detection_fixtures) { @fixtures_dir + '/passive_detection' }

    it "should return an empty array" do
      stub_request_to_fixture(:url => @module.url, :fixture => File.new(passive_detection_fixtures + '/no_theme.htm'))
      themes = @module.themes_from_passive_detection(:base_url => @module.url, :wp_content_dir => "wp-content")
      themes.should be_empty
    end

    it "should return the expected themes" do
      stub_request_to_fixture(:url => @module.url, :fixture => File.new(passive_detection_fixtures + '/various_themes.htm'))

      expected_theme_names = %w{ theme1 theme2 theme3 }
      expected_themes = []
      expected_theme_names.each do |theme_name|
        expected_themes << WpTheme.new(:base_url => @module.url,
                                       :path => "/themes/#{theme_name}/",
                                       :name => theme_name)
      end

      themes = @module.themes_from_passive_detection(:base_url => @module.url, :wp_content_dir => "wp-content")
      themes.should_not be_empty
      themes.length.should == expected_themes.length
      themes.sort.should == expected_themes.sort
    end
  end

  describe "#themes_from_aggressive_detection" do

    before :each do
      stub_request(:get, @module.uri.to_s).to_return(:status => 200)
      # Point all targets to a 404
      @targets.each do |target|
        stub_request(:get, target.get_full_url.to_s).to_return(:status => 404)
        # to_s calls readme_url
        stub_request(:get, target.readme_url.to_s).to_return(:status => 404)
      end
    end

    after :each do
      @passive_detection_fixture = SPEC_FIXTURES_DIR + "/empty-file" unless @passive_detection_fixture
      stub_request_to_fixture(:url => "#{@module.uri}/".sub(/\/\/$/, "/"), :fixture => @passive_detection_fixture)
      detected = @module.themes_from_aggressive_detection(@options)
      detected.length.should == @expected_themes.length
      detected.sort.should == @expected_themes.sort
    end

    it "should return an empty array" do
      @expected_themes = []
    end

    it "should return an array with 3 WpTheme (1 detected from passive method)" do
      @passive_detection_fixture = @fixtures_dir + "/passive_detection/one_theme.htm"
      @expected_themes = @targets.sample(2)
      @expected_themes.each do |p|
        stub_request(:get, p.get_full_url.to_s).to_return(:status => 200)
      end
      new_theme = WpTheme.new(:base_url => "http://example.localhost/",
                              :path => "/themes/custom-twentyten/",
                              :name => "custom-twentyten")
      stub_request(:get, new_theme.readme_url.to_s).to_return(:status => 200)
      @expected_themes << new_theme
    end

    # testing response codes
    WpTarget.valid_response_codes.each do |valid_response_code|
      it "should detect the theme if the reponse.code is #{valid_response_code}" do
        @expected_themes = []
        theme_url = [@targets.sample(1)[0]]
        theme_url.should_not be_nil
        theme_url.length.should == 1
        @expected_themes = theme_url
        stub_request(:get, theme_url[0].get_full_url.to_s).to_return(:status => valid_response_code)
      end
    end
  end
end
