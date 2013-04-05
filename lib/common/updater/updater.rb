# encoding: UTF-8

# This class act as an absract one
class Updater

  attr_reader :repo_directory

  # TODO : add a last '/ to repo_directory if it's not present
  def initialize(repo_directory = nil)
    @repo_directory = repo_directory
  end

  def is_installed?
    raise NotImplementedError
  end

  def local_revision_number
    raise NotImplementedError
  end

  def update
    raise NotImplementedError
  end

end
