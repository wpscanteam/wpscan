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

describe "WpscanOptions" do

  before :each do
    @wpscan_options = WpscanOptions.new
  end

  describe "#initialize" do

  end

  describe "#url=" do
    it "should raise an error if en empty or nil url is supplied" do
      expect { @wpscan_options.url = '' }.to raise_error
      expect { @wpscan_options.url = nil }.to raise_error
    end

    it "should add the http protocol if not present" do
      @wpscan_options.url = "example.com"
      @wpscan_options.url.should === "http://example.com"
    end

    it "should not add the http protocol if it's already present" do
      url = "http://example.com"
      @wpscan_options.url = url
      @wpscan_options.url.should === url
    end
  end

  describe "#threads=" do
    it "should convert an integer in a string into an integr" do
      @wpscan_options.threads = "10"
      @wpscan_options.threads.should be_an Integer
      @wpscan_options.threads.should === 10
    end

    it "should set to correct number of threads" do
      @wpscan_options.threads = 15
      @wpscan_options.threads.should be_an Integer
      @wpscan_options.threads.should === 15
    end
  end

  describe "#wordlist=" do
    it "should raise an error if the wordlist file does not exist" do
      expect { @wpscan_options.wordlist = "/i/do/not/exist.txt" }.to raise_error
    end

    it "should not raise an error" do
      wordlist_file = "#{SPEC_FIXTURES_WPSCAN_WPSCAN_OPTIONS_DIR}/wordlist.txt"

      @wpscan_options.wordlist = wordlist_file
      @wpscan_options.wordlist.should === wordlist_file
    end
  end

  describe "#proxy=" do
    it "should raise an error" do
      expect { @wpscan_options.proxy = 'invalidproxy' }.to raise_error
    end

    it "should not raise an error" do
      proxy = "127.0.0.1:3038"
      @wpscan_options.proxy = proxy
      @wpscan_options.proxy.should === proxy
    end
  end

  describe "#enumerate_plugins=" do
    it "should raise an error" do
      @wpscan_options.enumerate_only_vulnerable_plugins = true
      expect { @wpscan_options.enumerate_plugins = true }.to raise_error(RuntimeError,
                                                                         "You can't enumerate plugins and only vulnerable plugins at the same time, please choose only one")
    end

    it "should not raise an error" do
      @wpscan_options.enumerate_only_vulnerable_plugins = false
      @wpscan_options.enumerate_plugins = true

      @wpscan_options.enumerate_plugins.should be_true
    end
  end

  describe "#enumerate_themes=" do
    it "should raise an error" do
      @wpscan_options.enumerate_only_vulnerable_themes = true
      expect { @wpscan_options.enumerate_themes = true }.to raise_error(RuntimeError,
                                                                        "You can't enumerate themes and only vulnerable themes at the same time, please choose only one")
    end

    it "should not raise an error" do
      @wpscan_options.enumerate_only_vulnerable_themes = false
      @wpscan_options.enumerate_themes = true

      @wpscan_options.enumerate_themes.should be_true
    end
  end

  describe "#enumerate_only_vulnerable_plugins=" do
    it "should raise an error" do
      @wpscan_options.enumerate_plugins = true
      expect { @wpscan_options.enumerate_only_vulnerable_plugins = true }.to raise_error(RuntimeError,
                                                                                         "You can't enumerate plugins and only vulnerable plugins at the same time, please choose only one")
    end

    it "should not raise an error" do
      @wpscan_options.enumerate_plugins = false
      @wpscan_options.enumerate_only_vulnerable_plugins = true

      @wpscan_options.enumerate_only_vulnerable_plugins.should be_true
    end
  end

  describe "#enumerate_only_vulnerable_themes=" do
    it "should raise an error" do
      @wpscan_options.enumerate_themes = true
      expect { @wpscan_options.enumerate_only_vulnerable_themes = true }.to raise_error(RuntimeError,
                                                                                        "You can't enumerate themes and only vulnerable themes at the same time, please choose only one")
    end

    it "should not raise an error" do
      @wpscan_options.enumerate_themes = false
      @wpscan_options.enumerate_only_vulnerable_themes = true

      @wpscan_options.enumerate_only_vulnerable_themes.should be_true
    end
  end

  describe "#to_h" do
    it "should return an empty hash" do
      @wpscan_options.to_h.should be_a Hash
      @wpscan_options.to_h.should be_empty
    end

    it "should return a hash with :verbose = true" do
      expected = {:verbose => true}
      @wpscan_options.verbose = true

      @wpscan_options.to_h.should === expected
    end
  end

  describe "#has_options?" do
    it "should return false" do
      @wpscan_options.has_options?.should be_false
    end

    it "should return true" do
      @wpscan_options.verbose = false
      @wpscan_options.has_options?.should be_true
    end
  end

  describe "#clean_option" do
    after :each do
      WpscanOptions.clean_option(@option).should === @expected
    end

    it "should return 'url'" do
      @option = "--url"
      @expected = "url"
    end

    it "should return 'u'" do
      @option = "-u"
      @expected = 'u'
    end

    it "should return 'follow_redirection'" do
      @option = "--follow-redirection"
      @expected = "follow_redirection"
    end
  end

  describe "#option_to_instance_variable_setter" do
    after :each do
      WpscanOptions.option_to_instance_variable_setter(@argument).should === @expected
    end

    it "should return @url" do
      @argument = "--url"
      @expected = :url=
    end

    it "should return @verbose" do
      @argument = "-v"
      @expected = :verbose=
    end

    it "should return nil for -U" do
      @argument = "-U"
      @expected = nil
    end

    it "should return nil for --enumerate" do
      @argument = "--enumerate"
      @expected = nil
    end

    it "should return nil for -e" do
      @argument = "-e"
      @expected = nil
    end
  end

  describe "#is_long_option?" do
    it "should return true" do
      WpscanOptions.is_long_option?("--url").should be_true
    end

    it "should return false" do
      WpscanOptions.is_long_option?("hello").should be_false
      WpscanOptions.is_long_option?("--enumerate").should be_false
    end
  end

  describe "#enumerate_options_from_string" do
    after :each do
      if @argument
        wpscan_options = WpscanOptions.new
        wpscan_options.enumerate_options_from_string(@argument)
        wpscan_options.to_h.should === @expected_hash
      end
    end

    it "should raise an error if p and p! are " do
      expect { @wpscan_options.enumerate_options_from_string("pp!") }.to raise_error
    end

    it "should set enumerate_plugins to true" do
      @argument = 'p'
      @expected_hash = {:enumerate_plugins => true}
    end

    it "should set enumerate_only_vulnerable_plugins to tue" do
      @argument = "p!"
      @expected_hash = {:enumerate_only_vulnerable_plugins => true}
    end

    it "should set enumerate_timthumbs to true" do
      @argument = 't'
      @expected_hash = {:enumerate_timthumbs => true}
    end

    it "should set enumerate_usernames to true" do
      @argument = 'u'
      @expected_hash = {:enumerate_usernames => true}
    end

    it "should set enumerate_usernames to true and enumerate_usernames_range to (1..20)" do
      @argument = "u[1-20]"
      @expected_hash = {:enumerate_usernames => true, :enumerate_usernames_range => (1..20)}
    end

    # Let's try some multiple choices
    it "should set enumerate_timthumbs to true, enumerate_usernames to true, enumerate_usernames_range to (1..2)" do
      @argument = "u[1-2]t"
      @expected_hash = {
          :enumerate_usernames => true, :enumerate_usernames_range => (1..2),
          :enumerate_timthumbs => true
      }
    end
  end

  describe "#set_option_from_cli" do
    it "should raise an error with unknow option" do
      expect { @wpscan_options.set_option_from_cli("hello", "") }.to raise_error
    end

    it "should set @url to example.com" do
      @wpscan_options.set_option_from_cli("--url", "example.com")
      @wpscan_options.url.should === "http://example.com"
    end

    it "should set @enumerate_plugins to true" do
      @wpscan_options.set_option_from_cli("--enumerate", "p")
      @wpscan_options.enumerate_plugins.should be_true
      @wpscan_options.enumerate_only_vulnerable_plugins.should be_nil
    end

    it "should set @enumerate_only_vulnerable_plugins, @enumerate_timthumbs and @enumerate_usernames to true if no argument is given" do
      @wpscan_options.set_option_from_cli("--enumerate", '')
      @wpscan_options.enumerate_only_vulnerable_plugins.should be_true
      @wpscan_options.enumerate_timthumbs.should be_true
      @wpscan_options.enumerate_usernames.should be_true
    end
  end

  describe "#load_from_arguments" do
    after :each do
      set_argv(@argv)
      wpscan_options = WpscanOptions.load_from_arguments
      wpscan_options.to_h.should === @expected_hash
    end

    it "should return {}" do
      @argv = ''
      @expected_hash = {}
    end

    it "should return {:url => 'example.com'}" do
      @argv = "--url example.com"
      @expected_hash = {:url => "http://example.com"}
    end

    it "should return {:url => 'example.com'}" do
      @argv = "-u example.com"
      @expected_hash = {:url => "http://example.com"}
    end

    it "should return {:username => 'admin'}" do
      @argv = "--username admin"
      @expected_hash = {:username => "admin"}
    end

    it "should return {:username => 'Youhou'}" do
      @argv = "-U Youhou"
      @expected_hash = {:username => "Youhou"}
    end

    it "should return {:url => 'example.com', :threads => 5, :force => ''}" do
      @argv = "-u example.com --force -t 5"
      @expected_hash = {:url => "http://example.com", :threads => 5, :force => ""}
    end

    it "should return {:url => 'example.com', :enumerate_plugins => true, :enumerate_timthumbs => true}" do
      @argv = "-u example.com -e pt"
      @expected_hash = {:url => 'http://example.com', :enumerate_plugins => true, :enumerate_timthumbs => true}
    end
  end

end
