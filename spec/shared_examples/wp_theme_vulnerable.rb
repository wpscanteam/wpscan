# encoding: UTF-8

shared_examples 'WpTheme::Vulnerable' do

  describe '#vulns_file' do
    after { subject.vulns_file.should == @expected }

    context 'when :vulns_file is not set' do
      it 'returns the default one' do
        @expected = THEMES_VULNS_FILE
      end
    end

    context 'when the :vulns_file is already set' do
      it 'returns it' do
        @expected          = 'test.xml'
        subject.vulns_file = @expected
      end
    end
  end

  describe '#vulns_xpath' do
    its(:vulns_xpath) { should == "//theme[@name='theme-name']/vulnerability" }
  end

end
