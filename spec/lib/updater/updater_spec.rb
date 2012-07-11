require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Updater do

  before :all do
    class TestUpdater < Updater
    end
  end

  after :all do
    Object.send(:remove_const, :TestUpdater)
  end

  describe "non implementation of #is_installed?, #has_update? and #update" do
    it "should raise errors" do
      test_updater = TestUpdater.new
      methods_to_call = [:is_installed?, :update, :local_revision_number]

      methods_to_call.each do |method_to_call|
        expect { test_updater.send(method_to_call) }.to raise_error
      end
    end
  end

end
