# encoding: UTF-8

require 'spec_helper'

describe WpTimthumb do
  it_behaves_like 'WpTimthumb::Existable'
  it_behaves_like 'WpTimthumb::Versionable'

  subject(:wp_timthumb) { WpTimthumb.new(uri, options) }
  let(:uri)             { URI.parse('http://example.com/') }
  let(:options)         { { path: 'path-to/a/timtuhumb.php' } }

  describe '#==' do
    context 'when both url are equal' do
      it 'returns true' do
        expect(WpTimthumb.new(uri, path: 'timtuhumb.php')).
        to eq(
        WpTimthumb.new(uri, path: 'timtuhumb.php')
        )
      end
    end

    context 'when urls are different' do
      it 'returns false' do
        expect(WpTimthumb.new(uri, path: 'hello/timtuhumb.php')).
        not_to eq(
        WpTimthumb.new(uri, path: 'some-dir/timtuhumb.php')
        )
      end
    end
  end

end
