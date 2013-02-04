# encoding: UTF-8
#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
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
  describe '#initialize' do
    it 'should not raise an exception' do
      expect { WpPlugin.new(base_url: 'url', path: 'path', wp_content_dir: 'dir', name: 'name') }.to_not raise_error
    end

    it 'should not raise an exception (wp_content_dir not set)' do
      expect { WpPlugin.new(base_url: 'url', path: 'path', name: 'name') }.to_not raise_error
    end

    it 'should raise an exception (base_url not set)' do
      expect { WpPlugin.new(path: 'path', wp_content_dir: 'dir', name: 'name') }.to raise_error
    end

    it 'should raise an exception (path not set)' do
      expect { WpPlugin.new(base_url: 'url', wp_content_dir: 'dir', name: 'name') }.to raise_error
    end

    it 'should raise an exception (name not set)' do
      expect { WpPlugin.new(base_url: 'url', path: 'path', wp_content_dir: 'dir') }.to raise_error
    end
  end
end
