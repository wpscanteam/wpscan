# encoding: UTF-8

class UpdaterFactory

  def self.get_updater(repo_directory)
    self.available_updaters_classes().each do |updater_symbol|
      updater = Object.const_get(updater_symbol).new(repo_directory)

      if updater.is_installed?
        return updater
      end
    end
    nil
  end

  protected

  # return array of class symbols
  def self.available_updaters_classes
    Object.constants.grep(/^.+Updater$/)
  end

end
