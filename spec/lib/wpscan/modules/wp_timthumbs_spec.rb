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
    @module             = WpScanModuleSpec.new('http://example.localhost/')
    @fixtures_dir       = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_timthumbs'
    @theme_name         = "bueno"
    @timthumbs_file     = @fixtures_dir + '/timthumbs.txt'
    @targets_from_file  =
    [
      "http://example.localhost/wp-content/plugins/fotoslide/timthumb.php",
      "http://example.localhost/wp-content/plugins/feature-slideshow/timthumb.php"
    ]
    @targets_from_theme =
    [
      'http://example.localhost/wp-content/themes/' + @theme_name + '/timthumb.php',
      'http://example.localhost/wp-content/themes/' + @theme_name + '/lib/timthumb.php',
      'http://example.localhost/wp-content/themes/' + @theme_name + '/inc/timthumb.php',
      'http://example.localhost/wp-content/themes/' + @theme_name + '/includes/timthumb.php',
      'http://example.localhost/wp-content/themes/' + @theme_name + '/scripts/timthumb.php',
      'http://example.localhost/wp-content/themes/' + @theme_name + '/tools/timthumb.php',
      'http://example.localhost/wp-content/themes/' + @theme_name + '/functions/timthumb.php'
    ]

    @module.extend(WpTimthumbs)
  end

  describe "#timthumbs_file" do
    it "should return #{DATA_DIR}/timthumb.txt" do
      WpTimthumbs.timthumbs_file.should === "#{DATA_DIR}/timthumbs.txt"
    end

    it "should return hello/file.txt" do
      WpTimthumbs.timthumbs_file("hello/file.txt").should === "hello/file.txt"
    end
  end

  describe "#targets_url_from_theme" do
    it "should return the targets for the theme" do
      targets = @module.send(:targets_url_from_theme, @theme_name)

      targets.should_not be_empty
      targets.sort.should === @targets_from_theme.sort
    end
  end

  describe "#timthumbs_targets_url" do
    it "should return only the targets from the timthumbs file" do
      targets = @module.timthumbs_targets_url(:timthumbs_file => @timthumbs_file)

      targets.should_not be_empty
      targets.sort.should === @targets_from_file.sort
    end

    it "should return targets from timthumbs file and theme" do
      targets = @module.timthumbs_targets_url(:theme_name => @theme_name, :timthumbs_file => @timthumbs_file)

      targets.should_not be_empty
      targets.sort.should === (@targets_from_file + @targets_from_theme).sort
    end
  end

  describe "#timthumbs" do

    before :each do
      @module.timthumbs_targets_url(:theme_name => @theme_name, :timthumbs_file => @timthumbs_file).each do |target_url|
        stub_request(:get, target_url).to_return(:status => 404)
      end
    end

    it "should return an empty array" do
      timthumbs = @module.timthumbs(:theme_name => @theme_name, :timthumbs_file => @timthumbs_file)

      timthumbs.should be_empty
      @module.has_timthumbs?.should be_false
    end

    it "should return an array with 2 timthumbs url" do
      expected = []
      @module.timthumbs_targets_url(:theme_name => @theme_name, :timthumbs_file => @timthumbs_file).sample(2).each do |target_url|
        expected << target_url

        stub_request(:get, target_url).
          to_return(:status => 200, :body => File.new(@fixtures_dir + "/timthumb.php"))
      end

      timthumbs = @module.timthumbs(:theme_name => @theme_name, :timthumbs_file => @timthumbs_file)
      timthumbs.should_not be_empty
      timthumbs.sort.should === expected.sort
      @module.has_timthumbs?.should be_true
    end
  end

end
