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

require File.expand_path(File.dirname(__FILE__) + '/updater')

class GitUpdater < Updater

  def is_installed?
    %x[git #{repo_directory_arguments()} status 2>&1] =~ /On branch/ ? true : false
  end

  # Git has not a revsion number like SVN, so we will take the 7 first chars of the last commit hash
  def local_revision_number
    git_log = %x[git #{repo_directory_arguments()} log -1 2>&1]
    git_log[/commit ([0-9a-z]{7})/i, 1].to_s
  end

  def update
    %x[git #{repo_directory_arguments()} pull]
  end

  protected
  def repo_directory_arguments
    if @repo_directory
      return "--git-dir=\"#{@repo_directory}/.git\" --work-tree=\"#{@repo_directory}\""
    end
  end

end
