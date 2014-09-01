#encoding: UTF-8

require 'spec_helper'

describe WpItems do
  it_behaves_like 'WpItems::Detectable' do
    subject(:wp_items) { WpItems }
    let(:item_class)   { WpItem }
    let(:fixtures_dir) { COLLECTIONS_FIXTURES + '/wp_items/detectable' }

    let(:expected) do
      {
        request_params:                 { cache_ttl: 0, followlocation: true },
        targets_items_from_file:        [ WpItem.new(uri, name: 'item1'),
                                          WpItem.new(uri, name:'item-2'),
                                          WpItem.new(uri, name: 'mr-smith')],

        vulnerable_targets_items:       [ WpItem.new(uri, name: 'mr-smith'),
                                          WpItem.new(uri, name: 'neo')],

        # Any better way to do this ? :x
        passive_detection: WpItems.new << WpItem.new(uri, name: 'detect-me-1') <<
                                          WpItem.new(uri, name: 'detect-me-2') <<
                                          WpItem.new(uri, name: 'detect-me-3') <<
                                          WpItem.new(uri, name: 'detect-me-4') <<
                                          WpItem.new(uri, name: 'detect-me-5') <<
                                          WpItem.new(uri, name: 'detect-me-6') <<
                                          WpItem.new(uri, name: 'detect-me-7') <<
                                          WpItem.new(uri, name: 'detect-me-8') <<
                                          WpItem.new(uri, name: 'detect-me-9') <<
                                          WpItem.new(uri, name: 'detect-me-10') <<
                                          WpItem.new(uri, name: 'detect-me-11') <<
                                          WpItem.new(uri, name: 'detect-me-12') <<
                                          WpItem.new(uri, name: 'detect-me-13') <<
                                          WpItem.new(uri, name: 'detect-me-14')
      }
    end
  end
end
