#!/usr/bin/env ruby

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

# This Class Parses SVN Repositories via HTTP
class Svn_Parser

  attr_accessor :verbose, :svn_root, :keep_empty_dirs

  def initialize(svn_root, verbose, keep_empty_dirs = false)
    @svn_root         = svn_root
    @verbose          = verbose
    @keep_empty_dirs  = keep_empty_dirs
    @svn_browser      = Browser.instance
    @svn_hydra        = @svn_browser.hydra
  end

  def parse(dirs=nil)
    if dirs == nil
      dirs = get_root_directories
    end
    urls = get_svn_project_urls(dirs)
    get_svn_file_entries(urls)
  end

  #Private methods start here
  private

  # Gets all directories in the SVN root
  def get_root_directories
    dirs = []
    rootindex = @svn_browser.get(@svn_root).body
    rootindex.scan(%r{<li><a href=".+">(.+)/</a></li>}i).each do |dir|
      dirs << dir[0]
    end
    dirs.sort!
    dirs.uniq
  end

  def get_svn_project_urls(dirs)
    urls = []
    queue_count = 0
    # First get all trunk or version directories
    dirs.each do |dir|
      svnurl = @svn_root + dir + "/"
      request = @svn_browser.forge_request(svnurl)
      request.on_complete do |response|
        # trunk folder present
        if contains_trunk(response)
          puts "[+] Adding trunk on #{dir}" if @verbose
          urls << {:name => dir, :folder => "trunk"}
          # no trunk folder. This is true on theme svn repos
        else
          folders = response.body.scan(%r{^\s*<li><a href="(.+)/">.+/</a></li>$}i)
          if folders != nil and folders.length > 0
            last_version = folders.last[0]
            puts "[+] Adding #{last_version} on #{dir}" if @verbose
            urls << {:name => dir, :folder => last_version}
          else
            puts "[+] No content in #{dir}" if @verbose
          end
        end
      end
      queue_count += 1
      @svn_hydra.queue(request)
      # the wordpress server stops
      # responding if we dont use this.
      if queue_count == @svn_browser.max_threads
        @svn_hydra.run
        queue_count = 0
      end
    end
    @svn_hydra.run
    urls
  end

  # Get a file in each directory
  # TODO: exclude files like Thumbs.db (Example: wordpress-23-related-posts-plugin/)
  def get_svn_file_entries(dirs)
    entries = []
    queue_count = 0
    dirs.each do |dir|
      url = @svn_root + dir[:name] + "/" + dir[:folder] + "/"
      request = @svn_browser.forge_request(url)
      request.on_complete do |response|
        puts "[+] Parsing url #{url} [#{response.code.to_s}]" if @verbose
        file = response.body[%r{<li><a href="(.+\.[^/]+)">.+</a></li>}i, 1]
        # TODO: recursive parsing of subdirectories if there is no file in the root directory
        path = dir[:name] + "/"
        if file
          path += file
          entries << path
          puts "[+] Added #{path}" if @verbose
        elsif @keep_empty_dirs
          entries << path
          puts "[+] Added #{path}" if @verbose
        end
      end
      queue_count += 1
      @svn_hydra.queue(request)
      # the wordpress server stops
      # responding if we dont use this.
      if queue_count == @svn_browser.max_threads
        @svn_hydra.run
        queue_count = 0
      end
    end
    @svn_hydra.run
    entries
  end

  def contains_trunk(body)
    contains = false
    if !!(body =~ %r[<li><a href="trunk/">trunk/</a></li>]i)
      contains = true
    end
    contains
  end
end
