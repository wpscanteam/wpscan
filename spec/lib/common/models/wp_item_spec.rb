# encoding: UTF-8

require 'spec_helper'

describe WpItem do
  it_behaves_like 'WpItem::Existable'
  it_behaves_like 'WpItem::Findable#Found_From='
  it_behaves_like 'WpItem::Infos' do
    let(:changelog_url) { uri.merge('changelog.txt').to_s }
    let(:error_log_url) { uri.merge('error_log').to_s }
  end
  it_behaves_like 'WpItem::Versionable'
  it_behaves_like 'WpItem::Vulnerable' do
    let(:db_file)       { MODELS_FIXTURES + '/wp_item/vulnerable/items_vulns.json' }
    let(:identifier)    { 'neo' }
    let(:expected_refs)  { {
        'id'  => [2993],
        'url' => ['Ref 1', 'Ref 2'],
        'cve' => ['2011-001'],
        'secunia' => ['secunia'],
        'osvdb' => ['osvdb'],
        'metasploit' => ['exploit/ex1'],
        'exploitdb' => ['exploitdb']
    } }
    let(:expected_vulns) { Vulnerabilities.new(1, Vulnerability.new("I'm the one", 'XSS', expected_refs)) }
  end

  subject(:wp_item) { WpItem.new(uri, options) }
  let(:uri)         { URI.parse('http://example.com') }
  let(:options)     { {} }

  describe '#new' do
    context 'with no options' do
      its(:wp_content_dir) { is_expected.to eq 'wp-content' }
      its(:wp_plugins_dir) { is_expected.to eq 'wp-content/plugins' }
      its(:uri) { is_expected.to be uri }
    end

    context 'with :wp_content_dir' do
      let(:options) { { wp_content_dir: 'custom' } }

      its(:wp_content_dir) { is_expected.to eq 'custom' }
      its(:wp_plugins_dir) { is_expected.to eq 'custom/plugins' }
    end

    context 'with :wp_plugins_dir' do
      let(:options) { { wp_plugins_dir: 'c-plugins' } }

      its(:wp_content_dir) { is_expected.to eq 'wp-content' }
      its(:wp_plugins_dir) { is_expected.to eq 'c-plugins' }
    end
  end

  describe '#set_options' do
    context 'no an allowed option' do
      it 'ignores the option' do
        expect(wp_item).not_to receive(:not_allowed=)

        wp_item.send(:set_options, { not_allowed: 'owned' })
      end
    end

    context 'allowed option, w/o setter method' do
      it 'raises an error' do
        allow(wp_item).to receive(:allowed_options).and_return([:no_setter])

        expect {
          wp_item.send(:set_options, { no_setter: 'hello' })
        }.to raise_error('WpItem does not respond to no_setter=')
      end
    end
  end

  describe '#path=' do
    after do
      wp_item.path = @path
      expect(wp_item.path).to eq @expected
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
        allow(wp_item).to receive(:wp_content_dir).and_return('custom-content')
        allow(wp_item).to receive(:wp_plugins_dir).and_return('plugins')
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
  end

  describe '#uri' do
    context 'when the path is present' do
      it 'returns it with the uri' do
        path         = 'somedir/somefile.php'
        wp_item.path = path

        expect(wp_item.uri).to eq uri.merge(path)
      end
    end
  end

  describe '#<=>' do
    it 'bases the comparaison on the :name' do
      wp_item.name = 'a-name'
      other = WpItem.new(uri, name: 'other-name')

      expect(wp_item.<=>(other)).to be === 'a-name'.<=>('other-name')
    end
  end

  describe '#==' do
    context 'when the :name is the same' do
      it 'is ==' do
        wp_item.name = 'some-name'
        other = WpItem.new(uri, name: 'some-name')

        expect(wp_item).to eq other
      end
    end

    context 'otherwise' do
      it 'is not ==' do
        wp_item.name = 'Test'
        other = WpItem.new(uri, name: 'hello')

        expect(wp_item).not_to eq other
      end
    end
  end

  describe '#===' do
    let(:options)  { { name: 'a-name', version: '1.2' } }

    context 'when the :name and :version are the same' do
      it 'is ===' do
        expect(WpItem.new(uri, options)).to be === WpItem.new(uri.merge('yo'), options)
      end
    end

    context 'otherwise' do
      it 'is not ===' do
        expect(WpItem.new(uri, options)).not_to be === WpItem.new(uri, options.merge(version: '1.0'))
      end
    end
  end

end
