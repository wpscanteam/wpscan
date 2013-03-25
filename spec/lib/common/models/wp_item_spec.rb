# encoding: UTF-8

require 'spec_helper'

describe WpItem do
  it_behaves_like 'WpItem::Existable'
  it_behaves_like 'WpItem::Findable#Found_From='
  it_behaves_like 'WpItem::Infos' do
    let(:readme_url)    { uri.merge('readme.txt').to_s }
    let(:changelog_url) { uri.merge('changelog.txt').to_s }
    let(:error_log_url) { uri.merge('error_log').to_s }
  end
  it_behaves_like 'WpItem::Versionable'
  it_behaves_like 'WpItem::Vulnerable' do
    let(:vulns_file)     { MODELS_FIXTURES + '/wp_item/vulnerable/items_vulns.xml' }
    let(:vulns_xpath)    { "//item[@name='neo']/vulnerability" }
    let(:expected_vulns) { Vulnerabilities.new << Vulnerability.new("I'm the one", 'XSS', ['http://ref1.com']) }
  end

  subject(:wp_item) { WpItem.new(uri, options) }
  let(:uri)         { URI.parse('http://example.com') }
  let(:options)     { {} }

  describe '#new' do
    context 'with no options' do
      its(:wp_content_dir) { should == 'wp-content' }
      its(:wp_plugins_dir) { should == 'wp-content/plugins' }
      its(:uri) { should be uri }
    end

    context 'with :wp_content_dir' do
      let(:options) { { wp_content_dir: 'custom' } }

      its(:wp_content_dir) { should == 'custom' }
      its(:wp_plugins_dir) { should == 'custom/plugins' }
    end

    context 'with :wp_plugins_dir' do
      let(:options) { { wp_plugins_dir: 'c-plugins' } }

      its(:wp_content_dir) { should == 'wp-content' }
      its(:wp_plugins_dir) { should == 'c-plugins' }
    end
  end

  describe '#set_options' do
    context 'no an allowed option' do
      it 'ignores the option' do
        wp_item.should_not_receive(:not_allowed=)

        wp_item.send(:set_options, { not_allowed: 'owned' })
      end
    end

    context 'allowed option, w/o setter method' do
      it 'raises an error' do
        wp_item.stub(:allowed_options).and_return([:no_setter])

        expect {
          wp_item.send(:set_options, { no_setter: 'hello' })
        }.to raise_error('WpItem does not respond to no_setter=')
      end
    end
  end

  describe '#path=' do
    after do
      wp_item.path = @path
      wp_item.path.should == @expected
    end

    context 'with default variable value' do
      it 'replaces $wp-content$ by wp-content' do
        @path     = '$wp-content$/hello'
        @expected = 'wp-content/hello'
      end

      it 'replaces $wp-plugins$ by wp-content/plugins' do
        @path     = '$wp-plugins$/yolo/file.php'
        @expected = 'wp-content/plugins/yolo/file.php'
      end
    end

    context 'whith custom variable values' do
      before {
        wp_item.stub(:wp_content_dir).and_return('custom-content')
        wp_item.stub(:wp_plugins_dir).and_return('plugins')
      }

      it 'replaces $wp-content$ by custom-content' do
        @path     = '$wp-content$/file.php'
        @expected = 'custom-content/file.php'
      end

      it 'replaces $wp-plugins$ by plugins' do
        @path     = '$wp-plugins$/readme.txt'
        @expected = 'plugins/readme.txt'
      end
    end

    it 'also encodes chars' do
      @path     = 'some dir with spaces'
      @expected = 'some%20dir%20with%20spaces'
    end
  end

  describe '#uri' do
    context 'when the path is present' do
      it 'returns it with the uri' do
        path         = 'somedir/somefile.php'
        wp_item.path = path

        wp_item.uri.should == uri.merge(path)
      end
    end
  end

  describe '#<=>' do
    it 'bases the comparaison on the :name' do
      wp_item.name = 'a-name'
      other = WpItem.new(uri, name: 'other-name')

      wp_item.<=>(other).should === 'a-name'.<=>('other-name')
    end
  end

  describe '#==' do
    context 'when the :name is the same' do
      it 'is ==' do
        wp_item.name = 'some-name'
        other = WpItem.new(uri, name: 'some-name')

        wp_item.should == other
      end
    end

    context 'otherwise' do
      it 'is not ==' do
        wp_item.name = 'Test'
        other = WpItem.new(uri, name: 'hello')

        wp_item.should_not == other
      end
    end
  end

  describe '#===' do
    let(:options)  { { name: 'a-name', version: '1.2' } }

    context 'when the :name and :version are the same' do
      it 'is ===' do
        WpItem.new(uri, options).should === WpItem.new(uri.merge('yo'), options)
      end
    end

    context 'otherwise' do
      it 'is not ===' do
        WpItem.new(uri, options).should_not === WpItem.new(uri, options.merge(version: '1.0'))
      end
    end
  end

end
