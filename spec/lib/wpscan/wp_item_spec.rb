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

describe WpPlugin do
  describe "#initialize" do
    it "should create a correct instance" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.wp_content_dir.should == "wp-content"
      instance.base_url.should == "http://sub.example.com/path/to/wordpress/"
      instance.path.should == "test/asdf.php"
    end
  end

  describe "#get_full_url" do
    it "should return the correct url" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.get_full_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/asdf.php"
    end

    it "should return the correct url (custom wp_content_dir)" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins",
                            :wp_content_dir => "custom"
      )
      instance.get_full_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/asdf.php"
    end

    it "should trim / and add missing / before concatenating url" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins",
                            :wp_content_dir => "/custom/"
      )
      instance.get_full_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/asdf.php"
    end
  end

  describe "#get_url_without_filename" do
    it "should return the correct url" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/"
    end

    it "should return the correct url (custom wp_content_dir)" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins",
                            :wp_content_dir => "custom"
      )
      instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/"
    end

    it "should trim / and add missing / before concatenating url" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins",
                            :wp_content_dir => "/custom/"
      )
      instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/"
    end

    it "should not remove the last foldername" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/"
    end

    it "should return the correct url (https)" do
      instance = WpItem.new(:base_url => "https://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.get_url_without_filename.to_s.should == "https://sub.example.com/path/to/wordpress/wp-content/plugins/test/"
    end

    it "should add the last slash if it's not present" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test-one",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test-one/"
    end
  end

  describe "#version" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR + '/version' }

    before :each do
      @instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                             :path => "test/asdf.php",
                             :vulns_file => "XXX.xml",
                             :name => "test",
                             :vulns_xpath => "XX",
                             :type => "plugins"
      )
    end

    it "should return a version number" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200, :body => "Stable tag: 1.2.4.3.2.1")
      @instance.version.should == "1.2.4.3.2.1"
    end

    it "should not return a version number" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200, :body => "Stable tag: trunk")
      @instance.version.should be nil
    end

    it "should return nil if the version is invalid (IE : trunk etc)" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200,
                                                              :body => File.new(fixtures_dir + '/trunk-version.txt'))
      @instance.version.should be_nil
    end

    it "should return the version 0.4" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200,
                                                              :body => File.new(fixtures_dir + '/simple-login-lockdown-0.4.txt'))

      @instance.version.should === "0.4"
    end
  end

  describe "#directory_listing?" do
    before :each do
      @instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                             :path => "test/asdf.php",
                             :vulns_file => "XXX.xml",
                             :name => "test",
                             :vulns_xpath => "XX",
                             :type => "plugins"
      )
    end

    it "should return true" do
      stub_request(:get, @instance.get_url_without_filename.to_s).to_return(:status => 200,
                                                                            :body => "<html><head><title>Index of asdf</title></head></html>")
      @instance.directory_listing?.should == true
    end

    it "should return false" do
      stub_request(:get, @instance.get_url_without_filename.to_s).to_return(:status => 200,
                                                                            :body => "<html><head><title>My Wordpress Site</title></head></html>")
      @instance.directory_listing?.should == false
    end

    it "should return false on a 404" do
      stub_request(:get, @instance.get_url_without_filename.to_s.to_s).to_return(:status => 404)
      @instance.directory_listing?.should be_false
    end
  end

  describe "#extract_name_from_url" do
    it "should extract the correct name" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.extract_name_from_url.should == "test"
    end

    it "should extract the correct name (custom wp_content_dir)" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins",
                            :wp_content_dir => "custom"
      )
      instance.extract_name_from_url.should == "test"
    end

    it "should extract the correct name" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test2/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins",
                            :wp_content_dir => "/custom/"
      )
      instance.extract_name_from_url.should == "test2"
    end

    it "should extract the correct plugin name" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "testplugin/",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.extract_name_from_url.should == "testplugin"
    end

    it "should extract the correct theme name" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "testtheme/",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "themes"
      )
      instance.extract_name_from_url.should == "testtheme"
    end
  end

  describe "#to_s" do
    before :each do
      @instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                             :path => "test/asdf.php",
                             :vulns_file => "XXX.xml",
                             :name => "test",
                             :vulns_xpath => "XX",
                             :type => "plugins"
      )
    end

    it "should return the name including a version number" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200, :body => "Stable tag: 1.2.4.3.2.1")
      @instance.to_s.should == "test v1.2.4.3.2.1"
    end

    it "should not return the name without a version number" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200, :body => "Stable tag: trunk")
      @instance.to_s.should == "test"
    end
  end

  describe "#==" do
    before :each do
      @instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                             :path => "test/asdf.php",
                             :vulns_file => "XXX.xml",
                             :name => "test",
                             :vulns_xpath => "XX",
                             :type => "plugins"
      )
    end

    it "should return false" do
      instance2 = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                             :path => "newname/asdf.php",
                             :type => "plugins",
                             :vulns_file => "XXX.xml",
                             :vulns_xpath => "XX"
      )
      (@instance==instance2).should == false
    end

    it "should return true" do
      instance2 = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                             :path => "test/asdf.php",
                             :type => "plugins",
                             :vulns_file => "XXX.xml",
                             :vulns_xpath => "XX"
      )
      (@instance==instance2).should == true
    end
  end

  describe "#get_sub_folder" do
    it "should return themes" do
      item = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                        :path => "test/asdf.php",
                        :vulns_file => "XXX.xml",
                        :wp_content_dir => "wp-content",
                        :wp_plugins_dir => "wp-content/plugins",
                        :name => "test",
                        :vulns_xpath => "XX",
                        :type => "themes"
      )
      item.get_sub_folder.should == "themes"
    end

    it "should return themes" do
      item = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                        :path => "test/asdf.php",
                        :vulns_file => "XXX.xml",
                        :wp_content_dir => "wp-content",
                        :wp_plugins_dir => "wp-content/plugins",
                        :name => "test",
                        :vulns_xpath => "XX",
                        :type => "themes"
      )
      item.get_sub_folder.should == "themes"
    end

    it "should return nil" do
      item = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                        :path => "test/asdf.php",
                        :vulns_file => "XXX.xml",
                        :wp_content_dir => "wp-content",
                        :wp_plugins_dir => "wp-content/plugins",
                        :name => "test",
                        :vulns_xpath => "XX",
                        :type => "timthumbs"
      )
      item.get_sub_folder.should == nil
    end

    it "should raise an exception" do
      item = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                        :path => "test/asdf.php",
                        :vulns_file => "XXX.xml",
                        :wp_content_dir => "wp-content",
                        :wp_plugins_dir => "wp-content/plugins",
                        :name => "test",
                        :vulns_xpath => "XX",
                        :type => "type"
      )
      expect { item.get_sub_folder }.to raise_error(RuntimeError, "unknown type type")
    end
  end

  describe "#readme_url" do
    it "should return the corrent plugin readme url" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.readme_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/readme.txt"
    end

    it "should return the corrent plugin readme url (custom wp_content)" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins",
                            :wp_content_dir => "custom"
      )
      instance.readme_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/readme.txt"
    end

    it "should return the corrent theme readme url" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "themes"
      )
      instance.readme_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/themes/test/readme.txt"
    end

    it "should return the corrent theme readme url (custom wp_content)" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "themes",
                            :wp_content_dir => "custom"
      )
      instance.readme_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/themes/test/readme.txt"
    end
  end

  describe "#changelog_url" do
    it "should return the corrent plugin changelog url" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins"
      )
      instance.changelog_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/changelog.txt"
    end

    it "should return the corrent plugin changelog url (custom wp_content)" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "plugins",
                            :wp_content_dir => "custom"
      )
      instance.changelog_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/changelog.txt"
    end

    it "should return the corrent theme changelog url" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "themes"
      )
      instance.changelog_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/themes/test/changelog.txt"
    end

    it "should return the corrent theme changelog url (custom wp_content)" do
      instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                            :path => "test/asdf.php",
                            :vulns_file => "XXX.xml",
                            :name => "test",
                            :vulns_xpath => "XX",
                            :type => "themes",
                            :wp_content_dir => "custom"
      )
      instance.changelog_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/themes/test/changelog.txt"
    end
  end

  describe "#has_readme?" do
    before :each do
      @instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                             :path => "test/asdf.php",
                             :vulns_file => "XXX.xml",
                             :name => "test",
                             :vulns_xpath => "XX",
                             :type => "plugins"
      )
    end

    it "should return true" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200)
      @instance.has_readme?.should == true
    end

    it "should return false" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 403)
      @instance.has_readme?.should == false
    end
  end

  describe "#has_changelog?" do
    before :each do
      @instance = WpItem.new(:base_url => "http://sub.example.com/path/to/wordpress/",
                             :path => "test/asdf.php",
                             :vulns_file => "XXX.xml",
                             :name => "test",
                             :vulns_xpath => "XX",
                             :type => "plugins"
      )
    end

    it "should return true" do
      stub_request(:get, @instance.changelog_url.to_s).to_return(:status => 200)
      @instance.has_changelog?.should == true
    end

    it "should return false" do
      stub_request(:get, @instance.changelog_url.to_s).to_return(:status => 403)
      @instance.has_changelog?.should == false
    end
  end
end