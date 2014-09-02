#encoding: UTF-8

require 'spec_helper'

describe WpItems do
  it_behaves_like 'WpItems::Detectable' do
    subject(:wp_items) { WpItems }
    let(:item_class)   { WpItem }
    let(:fixtures_dir) { COLLECTIONS_FIXTURES + '/wp_items/detectable' }

    let(:expected) do
      {
        request_params:           { cache_ttl: 0, followlocation: true },
        targets_items_from_file:  [ WpItem.new(uri, name: 'item1'),
                                    WpItem.new(uri, name: 'item-2'),
                                    WpItem.new(uri, name: 'mr-smith')],

        vulnerable_targets_items: [ WpItem.new(uri, name: 'mr-smith'),
                                    WpItem.new(uri, name: 'neo')],

        passive_detection: (1..15).reduce(WpItems.new) { |o, i| o << WpItem.new(uri, name: "detect-me-#{i}") }
      }
    end
  end
end
