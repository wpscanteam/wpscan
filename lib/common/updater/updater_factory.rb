# encoding: UTF-8

# Factory
class UpdaterFactory
  def self.get_updater(repo_directory)
    available_updaters_classes.each do |updater_symbol|
      updater = Object.const_get(updater_symbol).new(repo_directory)

      return updater if updater.is_installed?
    end
    nil
  end

  protected

  # @return [ Array<Symbol> ] The symbols related to code updaters
  def self.available_updaters_classes
    Object.constants.grep(/^(?:Svn|Git|Test)Updater$/)
  end
end
