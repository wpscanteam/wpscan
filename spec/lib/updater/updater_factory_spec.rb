require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe UpdaterFactory do

  describe "#available_updaters_classes" do
    after :each do
      UpdaterFactory.available_updaters_classes.sort.should === @expected.sort
    end

    it "should return [:GitUpdater, :SvnUpdater]" do
      @expected = [:GitUpdater, :SvnUpdater]
    end

    it "should return [:TestUpdater, :GitUpdater, :SvnUpdater]" do
      class TestUpdater < Updater
      end

      @expected = [:GitUpdater, :SvnUpdater, :TestUpdater]
    end
  end

  # TODO : Find a way to test that
  describe "#get_updater" do

  end

end
