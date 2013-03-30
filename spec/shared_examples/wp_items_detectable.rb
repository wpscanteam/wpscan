# encoding: UTF-8

require WPSCAN_LIB_DIR + '/wp_target'

shared_examples 'WpItems::Detectable' do
  let(:vulns_file)         { fixtures_dir + '/vulns.xml' }
  let(:targets_items_file) { fixtures_dir + '/targets.txt' }
  let(:wp_content_dir)     { 'wp-content' }
  let(:wp_plugins_dir)     { wp_content_dir + '/plugins' }
  let(:wp_target)          { WpTarget.new(url, wp_content_dir: wp_content_dir, wp_plugins_dir: wp_plugins_dir) }
  let(:url)                { 'http://example.com/' }
  let(:uri)                { URI.parse(url) }
  let(:empty_file)         { SPEC_FIXTURES_DIR + '/empty-file' }

  before do
    if class_vulns_file = subject.vulns_file
      class_vulns_file.should == expected[:vulns_file]
    end

    subject.stub(:vulns_file).and_return(vulns_file)

    unless subject.item_xpath
      subject.stub(:item_xpath).and_return('//item')
    end
  end

  describe '::request_params' do
    it 'returns the default params' do
      subject.send(:request_params).should == expected[:request_params]
    end
  end

  describe '::item_class' do
    it 'returns the correct item class' do
      klass = subject.send(:item_class)

      klass.should be_a Class
      klass.should == item_class
    end
  end

  describe '::targets_items_from_file' do
    after do
      results = subject.send(:targets_items_from_file, file, wp_target, item_class, vulns_file)

      results.map { |i| i.name }.should == @expected.map { |i| i.name }

      unless results.empty?
        results.each do |item|
          item.should be_a item_class
        end
      end
    end

    context 'when an empty file' do
      let(:file) { empty_file }

      it 'returns an empty Array' do
        @expected = []
      end
    end

    context 'when a file' do
      let(:file) { targets_items_file }

      it 'returns the expected Array of WpItem' do
        @expected = expected[:targets_items_from_file]
      end
    end
  end

  describe '::vulnerable_targets_items' do
    after do
      results = subject.send(:vulnerable_targets_items, wp_target, item_class, vulns_file)

      results.map { |i| i.name }.should == @expected.map { |i| i.name }

      unless results.empty?
        results.each do |item|
          item.should be_a item_class
        end
      end
    end

    context 'when an empty file' do
      let(:vulns_file) { empty_file }

      it 'returns an empty Array' do
        @expected = []
      end
    end

    context 'when a file' do
      it 'returns the expected Array of WpItem' do
        @expected = expected[:vulnerable_targets_items]
      end
    end
  end

  describe '::targets_items' do
    let(:options) { {} }

    after do
      if @expected
        results = subject.send(:targets_items, wp_target, options)

        results.sort.map { |i| i.name }.should == @expected.sort.map { |i| i.name }
      end
    end

    context 'when :only_vulnerable' do
      let(:options) { { only_vulnerable: true } }

      it 'returns the expected Array of WpItem' do
        @expected = expected[:vulnerable_targets_items]
      end
    end

    context 'when not :only_vulnerable' do
      context 'when no :file' do
        it 'raises an error' do
          expect { subject.send(:targets_items, wp_target, options) }.to raise_error('A file must be supplied')
        end
      end

      context 'when :file' do
        let(:options) { { file: targets_items_file } }

        it 'returns the expected Array of WpItem' do
          @expected = (expected[:targets_items_from_file] + expected[:vulnerable_targets_items]).uniq {|t| t.name }
        end
      end
    end
  end

  describe '::passive_detection' do
    after do
      stub_request_to_fixture(url: wp_target.url, fixture: @fixture)

      results = subject.passive_detection(wp_target)

      results.should be_a subject
      results.map { |i| i.name }.should == @expected.sort.map { |i| i.name }
    end

    context 'when the page is empty' do
      it 'return an empty WpItems' do
        @fixture  = empty_file
        @expected = subject.new
      end
    end

    context 'when items are present' do
      it 'returns the excpected items' do
        @fixture  = fixtures_dir + '/passive_detection.html'
        @expected = expected[:passive_detection]
      end
    end
  end

  describe '::aggressive_detection' do
    def stub_targets_dont_exist(targets)
      targets.each { |t| t.stub(:exists?).and_return(false) }
    end

    let(:options) { {} }

    after do
      stub_request(:get, /.*/).to_return(status: 404)

      result = subject.aggressive_detection(wp_target, options)

      result.should be_a subject
      result.sort.map { |i| i.name }.should == @expected.sort.map { |i| i.name }
    end

    context 'when :only_vulnerable' do
      let(:options) { { only_vulnerable: true } }
      let(:targets) { expected[:vulnerable_targets_items] }

      it 'only checks vulnerable targets' do
        target    = targets.sample
        @expected = subject.new << target

        stub_targets_dont_exist(targets)
        target.stub(:exists?).and_return(true)

        subject.should_receive(:targets_items).and_return(targets)
      end

      context 'when all targets dont exist' do
        it 'returns an empty WpItems' do
          stub_targets_dont_exist(targets)
          subject.should_receive(:targets_items).and_return(targets)
          @expected = subject.new
        end
      end

    end

    context 'when no :only_vulnerable' do
      let(:targets) { (expected[:vulnerable_targets_items] + expected[:targets_items_from_file]).uniq { |t| t.name } }

      it 'checks all targets, and merge the results with passive_detection' do
        target    = targets.sample
        @expected = expected[:passive_detection] << target

        stub_targets_dont_exist(targets)
        target.stub(:exists?).and_return(true)

        subject.should_receive(:targets_items).and_return(targets)
        subject.should_receive(:passive_detection).and_return(expected[:passive_detection])
      end

      context 'when all targets dont exist' do
        it 'returns the result from passive_detection' do
          @expected = expected[:passive_detection]

          stub_targets_dont_exist(targets)
          subject.should_receive(:targets_items).and_return(targets)
          subject.should_receive(:passive_detection).and_return(@expected)
        end
      end
    end
  end

end
