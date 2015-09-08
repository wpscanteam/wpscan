#encoding: UTF-8

require 'spec_helper'

describe WpPlugins do
  it_behaves_like 'WpItems::Detectable' do
    subject(:wp_plugins) { WpPlugins }
    let(:item_class)     { WpPlugin }
    let(:fixtures_dir)   { COLLECTIONS_FIXTURES + '/wp_plugins/detectable' }

    let(:expected) do
      {
        request_params:                   { cache_ttl: 0, followlocation: true },
        vulns_file:                       PLUGINS_FILE,
        targets_items_from_file:          [ WpPlugin.new(uri, name: 'plugin1'),
                                            WpPlugin.new(uri, name:'plugin-2'),
                                            WpPlugin.new(uri, name: 'mr-smith')],

        vulnerable_targets_items:         [ WpPlugin.new(uri, name: 'mr-smith'),
                                            WpPlugin.new(uri, name: 'neo')],

        passive_detection: WpPlugins.new << WpPlugin.new(uri, name: 'escaped-url') <<
                                            WpPlugin.new(uri, name: 'link-tag') <<
                                            WpPlugin.new(uri, name: 'script-tag') <<
                                            WpPlugin.new(uri, name: 'style-tag') <<
                                            WpPlugin.new(uri, name: 'style-tag-import')
      }
    end
  end
end
