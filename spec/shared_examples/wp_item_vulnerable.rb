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

    before do
      stub_request(:get, /.*\/readme\.txt/i)
      stub_request(:get, /.*\/style\.css/i)
    end

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

  describe '#vulnerable?' do
    after do
      subject.stub(:vulnerabilities).and_return(@stub)
      subject.vulnerable?.should == @expected
    end

    it 'returns false when no vulnerabilities' do
      @stub     = []
      @expected = false
    end

    it 'returns true when vulnerabilities' do
      @stub     = ['not empty']
      @expected = true
    end
  end

  describe '#vulnerable_to?' do
    let(:version_orig) { '1.5.6' }
    let(:version_newer) { '1.6' }
    let(:version_older) { '1.0' }
    let(:newer) { Vulnerability.new('Newer', 'XSS', ['ref'], nil, version_newer) }
    let(:older) { Vulnerability.new('Older', 'XSS', ['ref'], nil, version_older) }
    let(:same) { Vulnerability.new('Same', 'XSS', ['ref'], nil, version_orig) }
    let(:no_fixed_info) { Vulnerability.new('Same', 'XSS', ['ref'], nil, nil) }

    before do
      stub_request(:get, /.*\/readme\.txt/i).to_return(status: 200, body: "Stable Tag: #{version_orig}")
      stub_request(:get, /.*\/style\.css/i).to_return(status: 200, body: "Version: #{version_orig}")
    end

    context 'check basic version comparing' do
      it 'returns true because checked version is newer' do
        subject.version.should == version_orig
        subject.vulnerable_to?(newer).should be_true
      end

      it 'returns false because checked version is older' do
        subject.version.should == version_orig
        subject.vulnerable_to?(older).should be_false
      end

      it 'returns false because checked version is the fixed version' do
        subject.version.should == version_orig
        subject.vulnerable_to?(same).should be_false
      end

      it 'returns true because no fixed_in version is provided' do
        subject.version.should == version_orig
        subject.vulnerable_to?(no_fixed_info).should be_true
      end
    end

    context 'no version found in wp_item' do
      before do
        stub_request(:get, /.*\/readme\.txt/i).to_return(status: 404)
        stub_request(:get, /.*\/style\.css/i).to_return(status: 404)
      end

      it 'returns true because no version can be detected' do
        subject.vulnerable_to?(newer).should be_true
        subject.vulnerable_to?(older).should be_true
        subject.vulnerable_to?(same).should be_true
      end
    end
  end

end
