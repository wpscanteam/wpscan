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
    @target_url   = 'http://example.localhost/'
    @module       = WpScanModuleSpec.new(@target_url)
    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_usernames'

    @module.extend(WpUsernames)
  end

  describe "#author_url" do
    it "should return the auhor url according to his id" do
      @module.author_url(1).should === "#{@target_url}?author=1"
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
        to_return(:status => 301, :headers => { 'location' => '/author/Youhou/'})

      usernames = @module.usernames
      usernames.should_not be_empty
      usernames.should === ["Youhou"]
    end

    it "should return an array with 1 username (from in the body response)" do
      stub_request(:get, @module.author_url(2)).
        to_return(:status => 200, :body => File.new(@fixtures_dir + '/admin.htm'))

      usernames = @module.usernames(:range => (1..2))
      usernames.should_not be_empty
      usernames.should === ["admin"]
    end

    it "should return an array with 1 username (testing duplicates)" do
      (2..3).each do |id|
        stub_request(:get, @module.author_url(id)).
          to_return(:status => 200, :body => File.new(@fixtures_dir + '/admin.htm'))
      end

      @module.usernames(:range => (1..3)).should === ["admin"]
    end

    it "should return an array with 2 usernames (one is a duplicate and should not be present twice)" do
      stub_request(:get, @module.author_url(4)).
        to_return(:status => 301, :headers => { 'location' => '/author/Youhou/'})

      stub_request(:get, @module.author_url(2)).
        to_return(:status => 200, :body => File.new(@fixtures_dir + '/admin.htm'))

      usernames = @module.usernames(:range => (1..5))
      usernames.should_not be_empty
      usernames.sort.should === ["admin", "Youhou"].sort
    end
  end

end
