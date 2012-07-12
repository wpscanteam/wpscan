require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe SvnUpdater do

  before :each do
    @svn_updater = SvnUpdater.new
  end

  describe "#is_installed?" do
    after :each do
      stub_system_command(@svn_updater, /^svn info/, @stub_value)
      @svn_updater.is_installed?.should === @expected
    end

    it "should return false if the svn command is not found" do
      @stub_value = "svn: command not found"
      @expected = false
    end

    it "should return false if the repository is not manage by svn" do
      @stub_value = "svn: '.' is not a working copy"
      @expected = false
    end

    it "should return true" do
      @stub_value = '<?xml version="1.0"?>
        <info>
          <entry kind="dir" path="." revision="362">
            <url>https://wpscan.googlecode.com/svn/trunk</url>
            <repository>
              <root>https://wpscan.googlecode.com/svn</root>
              <uuid>0b0242d5-46e6-2201-410d-bc09fd35266c</uuid>
            </repository>
            <wc-info>
              <schedule>normal</schedule>
              <depth>infinity</depth>
            </wc-info>
            <commit revision="362">
              <author>author@mail.tld</author>
              <date>2012-06-02T06:26:25.309806Z</date>
            </commit>
          </entry>
        </info>'
      @expected = true
    end
  end

  describe "#local_revision_number" do
    after :each do
      stub_system_command(@svn_updater, /^svn info/, @stub_value)
      @svn_updater.local_revision_number.should === @expected
    end

    it "should return 399" do
      @stub_value = '<?xml version="1.0"?>
        <info>
          <entry kind="dir" path="." revision="362">
            <url>https://wpscan.googlecode.com/svn/trunk</url>
            <repository>
              <root>https://wpscan.googlecode.com/svn</root>
              <uuid>0b0242d5-46e6-2201-410d-bc09fd35266c</uuid>
            </repository>
            <wc-info>
              <schedule>normal</schedule>
              <depth>infinity</depth>
            </wc-info>
            <commit revision="362">
              <author>author@mail.tld</author>
              <date>2012-06-02T06:26:25.309806Z</date>
            </commit>
          </entry>
        </info>'
      @expected = "362"
    end
  end

  describe "#update" do
    it "should do nothing xD" do
      stub_system_command(@svn_updater, /^svn up/, "At revision 425.")
      @svn_updater.update().should === "At revision 425."
    end
  end

end
