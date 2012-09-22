require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GitUpdater do

  before :each do
    @git_updater = GitUpdater.new
  end

  describe "#is_installed?" do
    after :each do
      stub_system_command(@git_updater, /^git .* status/, @stub_value)
      @git_updater.is_installed?.should === @expected
    end

    it "should return false if the command is not found" do
      @stub_value = "git: command not found"
      @expected = false
    end

    it "should return true if the repo is a git one" do
      @stub_value = "# On branch master\n# Changed but not updated:"
      @expected = true
    end
  end

  describe "#local_revision_number" do
    after :each do
      stub_system_command(@git_updater, /^git .* log/, @stub_value)
      @git_updater.local_revision_number.should === @expected
    end

    it "should return 79c01f3" do
      @stub_value = "
        commit 79c01f3ed535a8e33876ea091d8217cae7df4028
        Author: Moi <tadimm>
        Date:   Wed Jul 11 23:22:16 2012 +0100"
      @expected = "79c01f3"
    end
  end

  describe "#update" do
    it "should do nothing xD" do
      stub_system_command(@git_updater, /^git .* pull/, "Already up-to-date.")
      @git_updater.update().should === "Already up-to-date."
    end
  end
end
