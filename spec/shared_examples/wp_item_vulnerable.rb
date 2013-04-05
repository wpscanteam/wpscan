# encoding: UTF-8

shared_examples 'WpItem::Vulnerable' do

  # 2 variables have to be set in the described class or subject:
  #   let(:vulns_file)     { }
  #   let(:expected_vulns) { } The expected Vulnerabilities when using vulns_file and vulns_xpath
  #
  # 1 variable is optional, used if supplied, otherwise subject.vulns_xpath is used
  #   let(:vulns_xpath)    { }

  describe '#vulnerabilities' do
    let(:empty_file) { MODELS_FIXTURES + '/wp_item/vulnerable/empty.xml' }

    after do
      subject.vulns_file  = @vulns_file
      subject.vulns_xpath = vulns_xpath if defined?(vulns_xpath)

      result = subject.vulnerabilities
      result.should be_a Vulnerabilities
      result.should == @expected
    end

    context 'when the vulns_file is empty' do
      it 'returns an empty Vulnerabilities' do
        @vulns_file = empty_file
        @expected   = Vulnerabilities.new
      end
    end

    it 'returns the expected vulnerabilities' do
      @vulns_file = vulns_file
      @expected   = expected_vulns
    end
  end

end
