#encoding: UTF-8

require 'spec_helper'

describe WpThemes do
  before { stub_request(:get, /.+\/style.css$/).to_return(status: 200) }

  it_behaves_like 'WpItems::Detectable' do
    subject(:wp_themes) { WpThemes }
    let(:item_class)    { WpTheme }
    let(:fixtures_dir)  { COLLECTIONS_FIXTURES + '/wp_themes/detectable' }

    let(:expected) do
      {
        request_params:                  { cache_ttl: 0, followlocation: true },
        vulns_file:                      THEMES_FILE,
        targets_items_from_file:         [ WpTheme.new(uri, name: '3colours'),
                                           WpTheme.new(uri, name:'42k'),
                                           WpTheme.new(uri, name: 'a-ri')],

        vulnerable_targets_items:        [ WpTheme.new(uri, name: 'shopperpress'),
                                           WpTheme.new(uri, name: 'webfolio')],

        passive_detection: WpThemes.new << WpTheme.new(uri, name: 'theme1') <<
                                           WpTheme.new(uri, name: 'theme 2') <<
                                           WpTheme.new(uri, name: 'theme-3') <<
                                           WpTheme.new(uri, name: 'style-tag-import'),
                                          
        directory_detection:             [ WpTheme.new(uri, name: 'mr-smith', wp_local_dir: wp_local_dir) ]
      }
    end
  end
end
