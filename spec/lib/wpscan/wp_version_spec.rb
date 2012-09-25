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

describe WpVersion do

  before :all do
    @target_uri = URI.parse('http://example.localhost/')
    @browser = Browser.instance(:config_file => SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json')
  end

  describe "#find_from_meta_generator" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/meta-generator" }

    after :each do
      stub_request_to_fixture(:url => @target_uri.to_s, :fixture => @fixture)

      WpVersion.find_from_meta_generator(:base_url => @target_uri.to_s).should === @expected
    end

    it "should return nil if the meta-generator is not found" do
      @fixture = fixtures_dir + "/no-meta-generator.htm"
      @expected = nil
    end

    it "should return 3.3.2" do
      @fixture = fixtures_dir + "/3.3.2.htm"
      @expected = "3.3.2"
    end

    it "should return 3.4-beta4" do
      @fixture = fixtures_dir + "/3.4-beta4.htm"
      @expected = "3.4-beta4"
    end
  end

  describe "#find_from_rss_generator" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/rss-generator" }

    after :each do
      @status_code ||= 200
      stub_request_to_fixture(:url => @target_uri.merge("feed/").to_s, :status => @status_code, :fixture => @fixture)

      WpVersion.find_from_rss_generator(:base_url => @target_uri).should === @expected
    end

    it "should return nil on a 404" do
      @status_code = 404
      @fixture = SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/404.htm"
      @expected = nil
    end

    it "should return nil if the rss-generator is not found" do
      @fixture = fixtures_dir + "/no-rss-generator.htm"
      @expected = nil
    end

    it "should return nil if the version is not found (but the rss-generator is present)" do
      @fixture = fixtures_dir + "/no-version.htm"
      @expected = nil
    end

    it "shuld return 3.3.2" do
      @fixture = fixtures_dir + "/3.3.2.htm"
      @expected = "3.3.2"
    end

    it "should return 3.4-beta4" do
      @fixture = fixtures_dir + "/3.4-beta4.htm"
      @expected = "3.4-beta4"
    end
  end

  describe "#find_from_sitemap_generator" do
    after :each do
      stub_request(:get, @target_uri.merge("sitemap.xml").to_s).
          to_return(:status => 200, :body => @body)

      WpVersion.find_from_sitemap_generator(:base_url => @target_uri).should === @expected
    end

    it "should return nil if the generator is not found" do
      @body = ''
      @expected = nil
    end

    it "should return the version : 3.3.2" do
      @body = "<!-- generator=\"wordpress/3.3.2\" -->"
      @expected = "3.3.2"
    end

    it "should return nil if it's not a valid version, must contains at least one '.'" do
      @body = "<!-- generator=\"wordpress/5065\" -->"
      @expected = nil
    end
  end

  describe "#find_from_readme" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + '/readme' }

    after :each do
      @status_code ||= 200
      stub_request_to_fixture(:url => @target_uri.merge("readme.html").to_s, :status => @status_code, :fixture => @fixture)

      WpVersion.find_from_readme(:base_url => @target_uri).should === @expected
    end

    it "should return nil on a 404" do
      @status_code = 404
      @fixture = SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/404.htm"
      @expected = nil
    end

    it "should return nil if the version number is not present" do
      @fixture = fixtures_dir + "/empty-version.html"
      @expected = nil
    end

    it "should return 3.3.2" do
      @fixture = fixtures_dir + "/readme-3.3.2.html"
      @expected = "3.3.2"
    end
  end

  describe "#find_from_advanced_fingerprinting" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/advanced" }

    it "should return 3.2.1" do
      stub_request_to_fixture(:url => @target_uri.merge("wp-admin/js/wp-fullscreen.js").to_s,
                              :status => 200,
                              :fixture => "#{fixtures_dir}/3.2.1.js")
      version = WpVersion.find_from_advanced_fingerprinting(:base_url => @target_uri,
                                                            :wp_content_dir => "wp-content",
                                                            :version_xml => "#{fixtures_dir}/wp_versions.xml")
      version.should == "3.2.1"
    end
  end

  describe "#find_from_links_opml" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + "/opml" }

    it "should return 3.4.2" do
      stub_request_to_fixture(:url => @target_uri.merge("wp-links-opml.php").to_s,
                              :status => 200,
                              :fixture => "#{fixtures_dir}/wp-links-opml.xml")
      version = WpVersion.find_from_links_opml(:base_url => @target_uri)
      version.should == "3.4.2"
    end

    it "should return nil" do
      stub_request_to_fixture(:url => @target_uri.merge("wp-links-opml.php").to_s,
                              :status => 200,
                              :fixture => "#{fixtures_dir}/wp-links-opml-nogenerator.xml")
      version = WpVersion.find_from_links_opml(:base_url => @target_uri)
      version.should be_nil
    end
  end

  describe "#initialize" do
    it "should initialize a WpVersion object" do
      v = WpVersion.new(1, {:discovery_method => "method", :vulns_file => "asdf.xml"})
      v.number.should == 1
      v.discovery_method.should == "method"
    end
  end

  describe "#find" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR + '/advanced' }

    it "should find all versions" do
      # All requests get a HTTP 404
      stub_request(:any, /.*/).to_return(:status => 404)
      # Wordpress Version 3.2.1
      stub_request_to_fixture(:url => @target_uri.merge("wp-admin/js/wp-fullscreen.js").to_s,
                              :status => 200,
                              :fixture => "#{fixtures_dir}/3.2.1.js")
      version = WpVersion.find(@target_uri, "wp-content")
      version.number.should == "3.2.1"
      version.discovery_method.should == "advanced fingerprinting"
    end
  end

end
