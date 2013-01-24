# encoding: UTF-8

require 'spec_helper'

describe GitUpdater do

  before :each do
    @git_updater = GitUpdater.new
  end

  describe '#is_installed?' do
    after :each do
      stub_system_command(@git_updater, /^git .* status/, @stub_value)
      @git_updater.is_installed?.should === @expected
    end

    it 'should return false if the command is not found' do
      @stub_value = 'git: command not found'
      @expected   = false
    end

    it 'should return true if the repo is a git one' do
      @stub_value = "# On branch master\n# Changed but not updated:"
      @expected   = true
    end
  end

  describe '#local_revision_number' do
    after :each do
      stub_system_command(@git_updater, /^git .* log/, @stub_value)
      @git_updater.local_revision_number.should === @expected
    end

    it 'should return 79c01f3' do
      @stub_value = '
        commit 79c01f3ed535a8e33876ea091d8217cae7df4028
        Author: Moi <tadimm>
        Date:   Wed Jul 11 23:22:16 2012 +0100'
      @expected = '79c01f3'
    end
  end

  describe '#update' do
    it 'should do nothing xD' do
      stub_system_command(@git_updater, /^git .* pull/, 'Already up-to-date.')
      @git_updater.update().should === 'Already up-to-date.'
    end
  end

  describe '#has_local_changes?' do
    after :each do
      stub_system_command(@git_updater, /^git .* diff --exit-code 2>&1/, @stub_value)
      @git_updater.has_local_changes?.should === @expected
    end

    it 'should return true if there are local changes' do
      @stub_value = 'diff'
      @expected   = true
    end

    it 'should return false if there are no local changes' do
      @stub_value = ''
      @expected   = false
    end
  end

  describe '#reset_head' do
    it 'should reset the local repo' do
      stub_system_command(@git_updater, /^git .* reset --hard HEAD/, 'HEAD is now at')
      @git_updater.reset_head.should match(/^HEAD is now at/)
    end
  end

end
