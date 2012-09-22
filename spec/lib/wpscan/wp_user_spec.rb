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

require File.expand_path(File.dirname(__FILE__) + "/wpscan_helper")

describe WpUser do
  describe "#initialize" do
    it "should replace nil with empty" do
      user = WpUser.new(nil, nil, nil)
      user.name.should == "empty"
      user.id.should == "empty"
      user.nickname == "empty"
    end

    it "should initialize a user object" do
      user = WpUser.new("name", "id", "nickname")
      user.name.should == "name"
      user.id.should == "id"
      user.nickname == "nickname"
    end
  end

  describe "#<=>" do
    it "should return -1" do
      user1 = WpUser.new("b", nil, nil)
      user2 = WpUser.new("a", nil, nil)
      (user1<=>user2).should === -1
    end

    it "should return 0" do
      user1 = WpUser.new("a", nil, nil)
      user2 = WpUser.new("a", nil, nil)
      (user1<=>user2).should === 0
    end

    it "should return 1" do
      user1 = WpUser.new("a", nil, nil)
      user2 = WpUser.new("b", nil, nil)
      (user1<=>user2).should === 1
    end
  end

  describe "#===" do
    it "should return true" do
      user1 = WpUser.new("a", "id", "nick")
      user2 = WpUser.new("a", "id", "nick")
      (user1===user2).should be_true
    end

    it "should return false" do
      user1 = WpUser.new("a", "id", "nick")
      user2 = WpUser.new("b", "id", "nick")
      (user1===user2).should be_false
    end
  end

  describe "#eql?" do
    it "should return true" do
      user1 = WpUser.new("a", "id", "nick")
      user2 = WpUser.new("a", "id", "nick")
      (user1.eql? user2).should be_true
    end

    it "should return false" do
      user1 = WpUser.new("a", "id", "nick")
      user2 = WpUser.new("b", "id", "nick")
      (user1.eql? user2).should be_false
    end
  end
end