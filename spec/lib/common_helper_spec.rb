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

require File.expand_path(File.dirname(__FILE__) + '../../../lib/wpscan/wpscan_helper')

describe "common_helper" do
  describe "#get_equal_string" do
    after :each do
      output = get_equal_string_end(@input)
      output.should == @expected
    end

    it "sould return an empty string" do
      @input = [""]
      @expected = ""
    end

    it "sould return an empty string" do
      @input = []
      @expected = ""
    end

    it "sould return asdf" do
      @input = ["kjh asdf", "oijr asdf"]
      @expected = " asdf"
    end

    it "sould return &laquo;  BlogName" do
      @input = ["user1 &laquo;  BlogName",
                "user2 &laquo;  BlogName",
                "user3 &laquo;  BlogName",
                "user4 &laquo;  BlogName"]
      @expected = " &laquo;  BlogName"
    end

    it "sould return an empty string" do
      @input = %w{user1 user2 user3 user4}
      @expected = ""
    end

    it "sould return an empty string" do
      @input = ["user1 &laquo;  BlogName",
                "user2 &laquo;  BlogName",
                "user3 &laquo;  BlogName",
                "user4 &laquo;  BlogNamea"]
      @expected = ""
    end

    it "sould return an empty string" do
      @input = %w{ user1 }
      @expected = ""
    end

    it "sould return | test" do
      @input = ["admin | test", "test | test"]
      @expected = " | test"
    end
  end
end