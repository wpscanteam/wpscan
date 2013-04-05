# encoding: UTF-8

require 'common/updater/updater'

class SvnUpdater < Updater

  REVISION_PATTERN = /revision="(\d+)"/i
  TRUNK_URL        = 'https://github.com/wpscanteam/wpscan'

  def is_installed?
    %x[svn info "#@repo_directory" --xml 2>&1] =~ /revision=/ ? true : false
  end

  def local_revision_number
    local_revision = %x[svn info "#@repo_directory" --xml 2>&1]
    local_revision[REVISION_PATTERN, 1].to_s
  end

  def update
    %x[svn up "#@repo_directory"]
  end

end
