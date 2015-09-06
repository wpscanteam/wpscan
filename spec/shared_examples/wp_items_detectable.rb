# encoding: UTF-8

require WPSCAN_LIB_DIR + '/wp_target'

shared_examples 'WpItems::Detectable' do
  let(:vulns_file)         { fixtures_dir + '/vulns.json' }
  let(:targets_items_file) { fixtures_dir + '/targets.txt' }
  let(:wp_content_dir)     { 'wp-content' }
  let(:wp_plugins_dir)     { wp_content_dir + '/plugins' }
  let(:wp_target)          { WpTarget.new(url, wp_content_dir: wp_content_dir, wp_plugins_dir: wp_plugins_dir) }
  let(:url)                { 'http://example.com/' }
  let(:uri)                { URI.parse(url) }
  let(:empty_file)         { SPEC_FIXTURES_DIR + '/empty-file' }

  before do
    if class_vulns_file = subject.vulns_file
      expect(class_vulns_file).to eq expected[:vulns_file]
    end

    allow(subject).to receive(:vulns_file).and_return(vulns_file)

    unless subject.item_xpath
      allow(subject).to receive(:item_xpath).and_return('//item')
    end
  end

  describe '::request_params' do
    it 'returns the default params' do
      expect(subject.send(:request_params)).to eq expected[:request_params]
    end
  end

  describe '::item_class' do
    it 'returns the correct item class' do
      klass = subject.send(:item_class)

      expect(klass).to be_a Class
      expect(klass).to eq item_class
    end
  end

  describe '::targets_items' do
    let(:options) { { type: :all } }

    after do
      if @expected
        results = subject.send(:targets_items, wp_target, options)

        expect(results.sort.map { |i| i.name }).to eq @expected.sort.map { |i| i.name }
      end
    end

    context 'when :type = :vulnerable' do
      let(:options) { { type: :vulnerable } }

      it 'returns the expected Array of WpItem' do
        @expected = expected[:vulnerable_targets_items]
      end
    end
  end

  describe '::passive_detection' do
    after do
      stub_request_to_fixture(url: wp_target.url, fixture: @fixture)

      results = subject.passive_detection(wp_target)

      expect(results).to be_a subject
      expect(results.map { |i| i.name }).to eq @expected.sort.map { |i| i.name }
    end

    context 'when the page is empty' do
      it 'return an empty WpItems' do
        @fixture  = empty_file
        @expected = subject.new
      end
    end

    context 'when items are present' do
      it 'returns the expected items' do
        @fixture  = fixtures_dir + '/passive_detection.html'
        @expected = expected[:passive_detection]
      end
    end
  end

  describe '::aggressive_detection' do
    def stub_targets_dont_exist(targets)
      targets.each { |t| allow(t).to receive(:exists?).and_return(false) }
    end

    let(:options) { {} }

    after do
      stub_request(:get, /.*/).to_return(status: 404)

      result = subject.aggressive_detection(wp_target, options)

      expect(result).to be_a subject
      expect(result.sort.map { |i| i.name }).to eq @expected.sort.map { |i| i.name }
    end

    context 'when :type = :vulnerable' do
      let(:options) { { type: :vulnerable } }
      let(:targets) { expected[:vulnerable_targets_items] }

      it 'only checks and return vulnerable targets' do
        samples           = targets.sample(2)
        fixed_target      = samples[0]
        vulnerable_target = samples[1]

        stub_targets_dont_exist(targets)

        allow(vulnerable_target).to receive(:exists?).and_return(true)
        allow(vulnerable_target).to receive(:vulnerable?).and_return(true)

        allow(fixed_target).to receive(:exists?).and_return(true)
        allow(fixed_target).to receive(:vulnerable?).and_return(false)

        @expected = subject.new << vulnerable_target

        expect(subject).to receive(:targets_items).and_return(targets)
      end

      context 'when all targets dont exist' do
        it 'returns an empty WpItems' do
          stub_targets_dont_exist(targets)
          expect(subject).to receive(:targets_items).and_return(targets)
          @expected = subject.new
        end
      end
    end

    context 'when no :type = :vulnerable' do
      let(:targets) { (expected[:vulnerable_targets_items] + expected[:targets_items_from_file]).uniq { |t| t.name } }

      it 'checks all targets, and merge the results with passive_detection' do
        target    = targets.sample
        @expected = expected[:passive_detection] << target

        stub_targets_dont_exist(targets)
        allow(target).to receive(:exists?).and_return(true)

        expect(subject).to receive(:targets_items).and_return(targets)
        expect(subject).to receive(:passive_detection).and_return(expected[:passive_detection])
      end

      context 'when all targets dont exist' do
        it 'returns the result from passive_detection' do
          @expected = expected[:passive_detection]

          stub_targets_dont_exist(targets)
          expect(subject).to receive(:targets_items).and_return(targets)
          expect(subject).to receive(:passive_detection).and_return(@expected)
        end
      end
    end
  end

end
