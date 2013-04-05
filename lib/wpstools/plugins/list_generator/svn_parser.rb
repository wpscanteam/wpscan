# encoding: UTF-8

# This Class Parses SVN Repositories via HTTP
class SvnParser

  attr_accessor :verbose, :svn_root, :keep_empty_dirs

  def initialize(svn_root)
    @svn_root    = svn_root
    @svn_browser = Browser.instance
    @svn_hydra   = @svn_browser.hydra
  end

  def parse
    get_root_directories
  end

  #Private methods start here
  private

  # Gets all directories in the SVN root
  def get_root_directories
    dirs      = []
    rootindex = @svn_browser.get(@svn_root).body

    rootindex.scan(%r{<li><a href=".+">(.+)/</a></li>}i).each do |dir|
      dirs << dir[0]
    end

    dirs.sort!
    dirs.uniq
  end
end
