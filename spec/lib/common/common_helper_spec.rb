# encoding: UTF-8

require 'spec_helper'

describe 'common_helper' do
  describe '#get_equal_string' do
    after :each do
      output = get_equal_string_end(@input)

      output.should == @expected
    end

    it 'returns an empty string' do
      @input    = %w()
      @expected = ''
    end

    it 'returns an empty string' do
      @input    = []
      @expected = ''
    end

    it 'returns an empty string' do
      @input    = ['asdf', nil]
      @expected = ''
    end

    it 'returns an empty string' do
      @input    = [nil, 'asdf']
      @expected = ''
    end

    it 'returns asdf' do
      @input    = [nil, 'a asdf', nil, 'b asdf']
      @expected = ' asdf'
    end

    it 'returns asdf' do
      @input    = ['kjh asdf', 'oijr asdf']
      @expected = ' asdf'
    end

    it 'returns &laquo;  BlogName' do
      @input = ['user1 &laquo;  BlogName',
                'user2 &laquo;  BlogName',
                'user3 &laquo;  BlogName',
                'user4 &laquo;  BlogName']
      @expected = ' &laquo;  BlogName'
    end

    it 'returns an empty string' do
      @input    = %w{user1 user2 user3 user4}
      @expected = ''
    end

    it 'returns an empty string' do
      @input = ['user1 &laquo;  BlogName',
                'user2 &laquo;  BlogName',
                'user3 &laquo;  BlogName',
                'user4 &laquo;  BlogNamea']
      @expected = ''
    end

    it 'returns an empty string' do
      @input    = %w{ user1 }
      @expected = ''
    end

    it 'returns | test' do
      @input    = ['admin | test', 'test | test']
      @expected = ' | test'
    end
  end

  describe '#remove_base64_images_from_html' do
    after :each do
      output = remove_base64_images_from_html(@html)
      output.should == @expected
    end

    it 'removes the valid base64 image' do
      @html = '<img alt="" src="data:image/x-png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAsTAAALEwEAmpwYAAAABGdBTUEAALGOfPtRkwAAACBjSFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAABLElEQVR42qSTQStFURSFP7f3XygyoAwoYSYMPCIpk2egMFSmUvwCRpSRDIwYGbwyVuYykB9y914m951z7nHe6J26dc9u77XXWmdvJLF7/audqx9JYuvyW92LL0li8K2df2r17CPEVk7ftXTclyQqAMmRCwC5I3fS42a4W7y74VYDNAAuJA8AaXIsSACsDgAdAJeFrnnyoMBygKZJJ3b1It0AmsTMDPdEgrujJqHEwCxqznMaD2KgyCDRnEuo8qJhHvx/hcQDbzGoix5Yi4G1TcwZWNEDKwJU+WDkhg2ToDaD+M65YcVB8jg3Y5IY5VQAyyf9gLJw+CqAuYNnAczsPQpgevtBU937kDexcdssj8Ti0ZskMd97CRs3u//U2sjJzbtwH1+/Cf8jS/gbAMmWc42HzdIjAAAAAElFTkSuQmCC" />'
      @expected = '<img alt="" src="" />'
    end

    it 'ignores invalid base64 content' do
      @html = '<img alt="" src="data:image/x-png;base64,iVBORw0KGgo" />'
      @expected = @html
    end
  end
end