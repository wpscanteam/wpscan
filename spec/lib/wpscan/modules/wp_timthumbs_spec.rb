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

shared_examples_for "WpTimthumbs" do

  before :each do
    @options = {}
    @url = "http://example.localhost/"
    @theme_name = "bueno"
    @options[:base_url] = @url
    @options[:wp_content_dir] = "wp-content"
    @options[:name] = @theme_name
    @options[:error_404_hash] = "xx"
    @options[:show_progress_bar] = false
    @options[:only_vulnerable_ones] = false
    @options[:vulns_file] = "xx"
    @options[:type] = "timthumbs"
    @module = WpScanModuleSpec.new(@url)
    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + "/wp_timthumbs"
    @timthumbs_file = @fixtures_dir + "/timthumbs.txt"
    @targets_from_file =
        %w{
      http://example.localhost/wp-content/plugins/fotoslide/timthumb.php
      http://example.localhost/wp-content/plugins/feature-slideshow/timthumb.php
    }
    @targets_from_theme =
        [
            "http://example.localhost/wp-content/themes/" + @theme_name + "/timthumb.php",
            "http://example.localhost/wp-content/themes/" + @theme_name + "/lib/timthumb.php",
            "http://example.localhost/wp-content/themes/" + @theme_name + "/inc/timthumb.php",
            "http://example.localhost/wp-content/themes/" + @theme_name + "/includes/timthumb.php",
            "http://example.localhost/wp-content/themes/" + @theme_name + "/scripts/timthumb.php",
            "http://example.localhost/wp-content/themes/" + @theme_name + "/tools/timthumb.php",
            "http://example.localhost/wp-content/themes/" + @theme_name + "/functions/timthumb.php"
        ]

    @module.extend(WpTimthumbs)
  end

  describe "#targets_url_from_theme" do
    it "should return the targets for the theme" do
      targets = @module.send(:targets_url_from_theme, @theme_name, @options)

      targets.should_not be_empty
      targets.length.should > 0
      temp = []
      targets.each do |t|
        temp << t.get_full_url.to_s
      end
      temp.sort.should === @targets_from_theme.sort
    end
  end

  describe "#timthumbs and #has_timthumbs?" do
    before :each do
      @options[:file] = @timthumbs_file
      @targets_from_file.each do |url|
        stub_request(:get, url).to_return(:status => 404)
      end
    end

    it "should return an empty array" do
      timthumbs = @module.timthumbs(nil, @options)
      timthumbs.should be_empty
      @module.has_timthumbs?(nil, @options).should be_false
    end

    it "should return an array with 7 elements (from passive detection)" do
      stub_request(:get, %r{http://example\.localhost/wp-content/themes/my-theme/.*}).to_return(:status => 200)
      timthumbs = @module.timthumbs("my-theme", @options)
      timthumbs.length.should == 7
    end

    it "should return an array with 2 timthumbs url" do
      expected = []
      urls = []
      urls_hash = WpEnumerator.generate_items(@options)
      urls_hash.each do |u|
        url = u.get_full_url.to_s
        urls << url
        stub_request(:get, url).to_return(:status => 404)
      end
      urls.sample(2).each do |target_url|
        expected << target_url
        stub_request(:get, target_url).
            to_return(:status => 200, :body => File.new(@fixtures_dir + "/timthumb.php"))
      end

      timthumbs = @module.timthumbs(nil, @options)
      timthumbs.should_not be_empty

      temp = []
      timthumbs.each do |t|
        temp << t.get_full_url.to_s
      end
      temp.sort.should === expected.sort
      @module.has_timthumbs?(nil).should be_true
    end
  end
end
