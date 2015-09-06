# encoding: UTF-8

shared_examples 'WpItem::Vulnerable' do

  # 2 variables have to be set in the described class or subject:
  #   let(:db_file)     { }
  #   let(:expected_vulns) { } The expected Vulnerabilities when using db_file and vulns_xpath
  #
  # 1 variable is optional, used if supplied, otherwise subject.vulns_xpath is used
  #   let(:vulns_xpath)    { }

  describe '#vulnerabilities' do
    let(:empty_file) { MODELS_FIXTURES + '/wp_item/vulnerable/empty.json' }

    before do
      stub_request(:get, /.*\/readme\.txt/i)
      stub_request(:get, /.*\/style\.css/i)
    end

    after do
      subject.db_file    = @db_file
      subject.identifier = identifier if defined?(identifier)

      result = subject.vulnerabilities
      expect(result).to be_a Vulnerabilities
      expect(result).to eq @expected
    end

    context 'when the db_file is empty' do
      it 'returns an empty Vulnerabilities' do
        @db_file  = empty_file
        @expected = Vulnerabilities.new
      end
    end

    it 'returns the expected vulnerabilities' do
      @db_file   = db_file
      @expected  = expected_vulns
    end
  end

  describe '#vulnerable?' do
    after do
      allow(subject).to receive(:vulnerabilities).and_return(@stub)
      expect(subject.vulnerable?).to eq @expected
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
    let(:newer) { Vulnerability.new('Newer', 'XSS', { :url => ['http://ref.com'] }, version_newer) }
    let(:older) { Vulnerability.new('Older', 'XSS', { :url => ['http://ref.com'] }, version_older) }
    let(:same) { Vulnerability.new('Same', 'XSS', { :url => ['http://ref.com'] }, version_orig) }
    let(:no_fixed_info) { Vulnerability.new('Same', 'XSS', { :url => ['http://ref.com'] }, nil) }

    before do
      stub_request(:get, /.*\/readme\.txt/i).to_return(status: 200, body: "Stable Tag: #{version_orig}")
      stub_request(:get, /.*\/style\.css/i).to_return(status: 200, body: "Version: #{version_orig}")
    end

    context 'check basic version comparing' do
      it 'returns true because checked version is newer' do
        expect(subject.version).to eq version_orig
        expect(subject.vulnerable_to?(newer)).to be_truthy
      end

      it 'returns false because checked version is older' do
        expect(subject.version).to eq version_orig
        expect(subject.vulnerable_to?(older)).to be_falsey
      end

      it 'returns false because checked version is the fixed version' do
        expect(subject.version).to eq version_orig
        expect(subject.vulnerable_to?(same)).to be_falsey
      end

      it 'returns true because no fixed_in version is provided' do
        expect(subject.version).to eq version_orig
        expect(subject.vulnerable_to?(no_fixed_info)).to be_truthy
      end
    end

    context 'no version found in wp_item' do
      before do
        stub_request(:get, /.*\/readme\.txt/i).to_return(status: 404)
        stub_request(:get, /.*\/style\.css/i).to_return(status: 404)
      end

      it 'returns true because no version can be detected' do
        expect(subject.vulnerable_to?(newer)).to be_truthy
        expect(subject.vulnerable_to?(older)).to be_truthy
        expect(subject.vulnerable_to?(same)).to be_truthy
      end
    end
  end

end
