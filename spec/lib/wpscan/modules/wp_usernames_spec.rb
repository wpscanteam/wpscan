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

shared_examples_for "WpUsernames" do

  before :each do
    @target_url = 'http://example.localhost/'
    @module = WpScanModuleSpec.new(@target_url)
    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_usernames'

    @module.extend(WpUsernames)
  end

  describe "#author_url" do
    it "should return the auhor url according to his id" do
      @module.author_url(1).should === "#@target_url?author=1"
    end
  end

  describe "#usernames" do
    before :each do
      (1..10).each do |index|
        stub_request(:get, @module.author_url(index)).to_return(:status => 404)
      end
    end

    it "should return an empty array" do
      @module.usernames.should be_empty
    end

    it "should return an array with 1 username (from header location)" do
      stub_request(:get, @module.author_url(3)).
          to_return(:status => 301, :headers => {'location' => '/author/Youhou/'})

      usernames = @module.usernames
      usernames.should_not be_empty
      usernames.length.should == 1
      usernames[0].id.should == 3
      usernames[0].name.should == "Youhou"
      usernames[0].nickname.should == "empty"
    end

    it "should return an array with 1 username (from in the body response)" do
      stub_request(:get, @module.author_url(2)).
          to_return(:status => 200, :body => File.new(@fixtures_dir + '/admin.htm'))

      usernames = @module.usernames(:range => (1..2))
      usernames.should_not be_empty
      usernames.eql?([WpUser.new("admin", 2, "admin | Wordpress 3.3.2")]).should be_true
    end

    it "should return an array with 2 usernames (one is a duplicate and should not be present twice)" do
      stub_request(:get, @module.author_url(4)).
          to_return(:status => 301, :headers => {'location' => '/author/Youhou/'})

      stub_request(:get, @module.author_url(2)).
          to_return(:status => 200, :body => File.new(@fixtures_dir + '/admin.htm'))

      usernames = @module.usernames(:range => (1..5))
      usernames.should_not be_empty
      expected = [WpUser.new("admin", 2, "admin | Wordpress 3.3.2"),
                  WpUser.new("Youhou", 4, "empty")]

      usernames.sort_by { |u| u.name }.eql?(expected.sort_by { |u| u.name }).should be_true
    end
  end

  describe "#get_nickname_from_url" do
    after :each do
      url = "http://example.localhost/"
      stub_request(:get, url).to_return(:status => @status, :body => @content)
      username = @module.get_nickname_from_url(url)
      username.should === @expected
    end

    it "should return nil" do
      @status = 200
      @content = ""
      @expected = nil
    end

    it "should return nil" do
      @status = 400
      @content = ""
      @expected = nil
    end

    it "should return admin" do
      @status = 200
      @content = "<title>admin</title>"
      @expected = "admin"
    end

    it "should return nil" do
      @status = 201
      @content = "<title>admin</title>"
      @expected = nil
    end
  end

  describe "#get_nickname_from_response" do
    after :each do
      url = "http://example.localhost/"
      stub_request(:get, url).to_return(:status => @status, :body => @content)
      resp = Browser.instance.get(url)
      username = @module.get_nickname_from_response(resp)
      username.should === @expected
    end

    it "should return nil" do
      @status = 200
      @content = ""
      @expected = nil
    end

    it "should return nil" do
      @status = 400
      @content = ""
      @expected = nil
    end

    it "should return admin" do
      @status = 200
      @content = "<title>admin</title>"
      @expected = "admin"
    end

    it "should return nil" do
      @status = 201
      @content = "<title>admin</title>"
      @expected = nil
    end
  end

  describe "#extract_nickname_from_body" do
    after :each do
      result = @module.extract_nickname_from_body(@body)
      result.should === @expected
    end

    it "should return admin" do
      @body = "<title>admin</title>"
      @expected = "admin"
    end

    it "should return nil" do
      @body = "<title>adm<in</title>"
      @expected = nil
    end

    it "should return nil" do
      @body = "<titler>admin</titler>"
      @expected = nil
    end

    it "should return admin | " do
      @body = "<title>admin | </title>"
      @expected = "admin | "
    end

    it "should return an empty string" do
      @body = "<title></title>"
      @expected = ""
    end
  end

  describe "#remove_junk_from_nickname" do
    it "should throw an exception" do
      @input = nil
      expect { @module.remove_junk_from_nickname(@input) }.to raise_error(RuntimeError, "Need an array as input")
    end

    it "should not throw an exception" do
      @input = []
      expect { @module.remove_junk_from_nickname(@input) }.to_not raise_error
    end

    it "should throw an exception" do
      @input = [WpOptions.new]
      expect { @module.remove_junk_from_nickname(@input) }.to raise_error(RuntimeError, "Items must be of type WpUser")
    end
  end

  describe "#remove_junk_from_nickname" do
    after :each do
      result = @module.remove_junk_from_nickname(@input)
      result.eql?(@expected).should === true
    end

    it "should return an empty array" do
      @input = []
      @expected = @input
    end

    it "should return input object" do
      @input = [WpUser.new(nil, nil, nil)]
      @expected = @input
    end

    it "should return input object" do
      @input = [WpUser.new("", "", "")]
      @expected = @input
    end

    it "should remove asdf" do
      @input = [WpUser.new(nil, nil, "lkjh asdf"), WpUser.new(nil, nil, "ijrjd asdf")]
      @expected = [WpUser.new(nil, nil, "lkjh"), WpUser.new(nil, nil, "ijrjd")]
    end

    it "should return unmodified input object" do
      @input = [WpUser.new(nil, nil, "lkjh asdfa"), WpUser.new(nil, nil, "ijrjd asdf")]
      @expected = @input
    end

    it "should return input object" do
      @input = [WpUser.new(nil, nil, "lkjh asdf")]
      @expected = @input
    end

    it "should return lkhj asdf" do
      @input = [WpUser.new(nil, nil, "lkhj asdf"), WpUser.new(nil, nil, "lkhj asdf")]
      @expected = [WpUser.new(nil, nil, ""), WpUser.new(nil, nil, "")]
    end
  end
end
