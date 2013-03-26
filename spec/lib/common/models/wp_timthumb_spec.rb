# encoding: UTF-8

require 'spec_helper'

describe WpTimthumb do
  it_behaves_like 'WpTimthumb::Existable'
  it_behaves_like 'WpTimthumb::Versionable'

  subject(:wp_timthumb) { WpTimthumb.new(uri, options) }
  let(:uri)             { URI.parse('http://example.com/') }
  let(:options)         { { path: 'path-to/a/timtuhumb.php' } }

end
