# encoding: UTF-8

require 'common/updater/updater'

class GitUpdater < Updater

  def is_installed?
    %x[git #{repo_directory_arguments()} status 2>&1] =~ /On branch/ ? true : false
  end

  # Git has not a revsion number like SVN,
  # so we will take the 7 first chars of the last commit hash
  def local_revision_number
    git_log = %x[git #{repo_directory_arguments()} log -1 2>&1]
    git_log[/commit ([0-9a-z]{7})/i, 1].to_s
  end

  def update
    %x[git #{repo_directory_arguments()} pull]
  end

  def has_local_changes?
    %x[git #{repo_directory_arguments()} diff --exit-code 2>&1] =~ /diff/ ? true : false
  end

  def reset_head
    %x[git #{repo_directory_arguments()} reset --hard HEAD]
  end

  protected
  def repo_directory_arguments
    if @repo_directory
      return "--git-dir=\"#{@repo_directory}/.git\" --work-tree=\"#{@repo_directory}\""
    end
  end

end
