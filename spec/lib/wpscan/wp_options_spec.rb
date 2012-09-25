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

describe WpOptions do
  describe "#check_options" do
    before :each do
      @options = {}
      @options[:base_url] = "url"
      @options[:only_vulnerable_ones] = false
      @options[:file] = "file"
      @options[:vulns_file] = "vulns_file"
      @options[:vulns_xpath] = "vulns_xpath"
      @options[:vulns_xpath_2] = "vulns_xpath_2"
      @options[:wp_content_dir] = "wp_content_dir"
      @options[:show_progress_bar] = true
      @options[:error_404_hash] = "error_404_hash"
      @options[:type] = "type"

      @message = ""
    end

    after :each do
      expect { WpOptions.check_options(@options) }.to raise_error(RuntimeError, @message)
    end

    it "should raise an exception (base_url empty)" do
      @options[:base_url] = ""
      @message = "base_url must be set"
    end

    it "should raise an exception (base_url nil)" do
      @options[:base_url] = nil
      @message = "base_url must be set"
    end

    it "should raise an exception (only_vulnerable_ones nil)" do
      @options[:only_vulnerable_ones] = nil
      @message = "only_vulnerable_ones must be set"
    end

    it "should raise an exception (file empty)" do
      @options[:file] = ""
      @message = "file must be set"
    end

    it "should raise an exception (file nil)" do
      @options[:file] = nil
      @message = "file must be set"
    end

    it "should raise an exception (vulns_file empty)" do
      @options[:vulns_file] = ""
      @message = "vulns_file must be set"
    end

    it "should raise an exception (vulns_file nil)" do
      @options[:vulns_file] = nil
      @message = "vulns_file must be set"
    end

    it "should raise an exception (vulns_xpath empty)" do
      @options[:vulns_xpath] = ""
      @message = "vulns_xpath must be set"
    end

    it "should raise an exception (vulns_xpath nil)" do
      @options[:vulns_xpath] = nil
      @message = "vulns_xpath must be set"
    end

    it "should raise an exception (vulns_xpath_2 empty)" do
      @options[:vulns_xpath_2] = ""
      @message = "vulns_xpath_2 must be set"
    end

    it "should raise an exception (vulns_xpath_2 nil)" do
      @options[:vulns_xpath_2] = nil
      @message = "vulns_xpath_2 must be set"
    end

    it "should raise an exception (wp_content_dir empty)" do
      @options[:wp_content_dir] = ""
      @message = "wp_content_dir must be set"
    end

    it "should raise an exception (wp_content_dir nil)" do
      @options[:wp_content_dir] = nil
      @message = "wp_content_dir must be set"
    end

    it "should raise an exception (show_progress_bar nil)" do
      @options[:show_progress_bar] = nil
      @message = "show_progress_bar must be set"
    end

    it "should raise an exception (error_404_hash empty)" do
      @options[:error_404_hash] = ""
      @message = "error_404_hash must be set"
    end

    it "should raise an exception (error_404_hash nil)" do
      @options[:error_404_hash] = nil
      @message = "error_404_hash must be set"
    end

    it "should raise an exception (type empty)" do
      @options[:type] = ""
      @message = "type must be set"
    end

    it "should raise an exception (type nil)" do
      @options[:type] = nil
      @message = "type must be set"
    end

    it "should raise an exception (type unknown)" do
      @options[:type] = "unknown"
      @message = "Unknown type unknown"
    end
  end
end