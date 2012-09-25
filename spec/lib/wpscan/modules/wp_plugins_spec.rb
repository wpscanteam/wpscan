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

shared_examples_for "WpPlugins" do

  before :all do
    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_plugins'
    @plugins_file = @fixtures_dir + "/plugins.txt"
    @plugin_vulns_file = @fixtures_dir + "/plugin_vulns.xml"

    @wp_url = "http://example.localhost/"
  end

  before :each do
    @module = WpScanModuleSpec.new(@wp_url)
    @module.error_404_hash = Digest::MD5.hexdigest("Error 404!")
    @module.extend(WpPlugins)

    @options = {:base_url => @wp_url,
                :only_vulnerable_ones => false,
                :show_progress_bar => false,
                :error_404_hash => Digest::MD5.hexdigest("Error 404!"),
                :vulns_file => @plugin_vulns_file,
                :file => @plugins_file,
                :type => "plugins",
                :wp_content_dir => "wp-content",
                :vulns_xpath_2 => "//plugin"
    }
    File.exist?(@plugin_vulns_file).should == true
    File.exist?(@plugins_file).should == true
    @targets = [WpPlugin.new({:base_url => "http://example.localhost/",
                              :path => "exclude-pages/exclude_pages.php",
                              :wp_content_dir => "wp-content",
                              :name => "exclude-pages"}),
                WpPlugin.new({:base_url => "http://example.localhost/",
                              :path => "display-widgets/display-widgets.php",
                              :wp_content_dir => "wp-content",
                              :name => "display-widgets"}),
                WpPlugin.new({:base_url => "http://example.localhost/",
                              :path => "media-library",
                              :wp_content_dir => "wp-content",
                              :name => "media-library"}),
                WpPlugin.new({:base_url => "http://example.localhost/",
                              :path => "deans",
                              :wp_content_dir => "wp-content",
                              :name => "deans"}),
                WpPlugin.new({:base_url => "http://example.localhost/",
                              :path => "formidable/formidable.php",
                              :wp_content_dir => "wp-content",
                              :name => "formidable"}),
                WpPlugin.new({:base_url => "http://example.localhost/",
                              :path => "regenerate-thumbnails/readme.txt",
                              :wp_content_dir => "wp-content",
                              :name => "regenerate-thumbnails"})]
  end

  describe "#plugins_from_passive_detection" do
    let(:passive_detection_fixtures) { @fixtures_dir + '/passive_detection' }

    it "should return an empty array" do
      stub_request_to_fixture(:url => @module.url, :fixture => File.new(passive_detection_fixtures + '/no_plugins.htm'))
      plugins = @module.plugins_from_passive_detection(:base_url => @module.url, :wp_content_dir => "wp-content")
      plugins.should be_empty
    end

    it "should return the expected plugins" do
      stub_request_to_fixture(:url => @module.url, :fixture => File.new(passive_detection_fixtures + '/various_plugins.htm'))

      expected_plugin_names = %w{
        wp-minify
        comment-info-tip
        tweet-blender
        optinpop
        s2member
        wp-polls
        commentluv
      }
      expected_plugins = []
      expected_plugin_names.each do |plugin_name|
        expected_plugins << WpPlugin.new(:base_url => @module.url,
                                         :path => "/plugins/#{plugin_name}/",
                                         :name => plugin_name)
      end

      plugins = @module.plugins_from_passive_detection(:base_url => @module.url, :wp_content_dir => "wp-content")
      plugins.should_not be_empty
      plugins.length.should == expected_plugins.length
      plugins.sort.should == expected_plugins.sort
    end
  end

  describe "#plugins_from_aggressive_detection" do

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
      detected = @module.plugins_from_aggressive_detection(@options)
      detected.length.should == @expected_plugins.length
      detected.sort.should == @expected_plugins.sort
    end

    it "should return an empty array" do
      @expected_plugins = []
    end

    it "should return an array with 3 WpPlugin (1 detected from passive method)" do
      @passive_detection_fixture = @fixtures_dir + "/passive_detection/one_plugin.htm"
      @expected_plugins = @targets.sample(2)
      @expected_plugins.each do |p|
        stub_request(:get, p.get_full_url.to_s).to_return(:status => 200)
      end
      new_plugin = WpPlugin.new(:base_url => "http://example.localhost/",
                                :path => "/plugins/comment-info-tip/",
                                :name => "comment-info-tip")
      stub_request(:get, new_plugin.readme_url.to_s).to_return(:status => 200)
      @expected_plugins << new_plugin
    end

    # testing response codes
    WpTarget.valid_response_codes.each do |valid_response_code|
      it "should detect the plugin if the reponse.code is #{valid_response_code}" do
        @expected_plugins = []
        plugin_url = [@targets.sample(1)[0]]
        plugin_url.should_not be_nil
        plugin_url.length.should == 1
        @expected_plugins = plugin_url
        stub_request(:get, plugin_url[0].get_full_url.to_s).to_return(:status => valid_response_code)
      end
    end
  end
end
