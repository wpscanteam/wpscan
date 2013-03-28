# encoding: UTF-8

shared_examples 'WpVersion::Vulnerable' do

  describe '#vulns_file' do
    after { subject.vulns_file.should == @expected }

    context 'when :vulns_file is no set' do
      it 'returns the default one' do
        @expected = WP_VULNS_FILE
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
    its(:vulns_xpath) { should == "//wordpress[@version='1.2']/vulnerability" }
  end

end
