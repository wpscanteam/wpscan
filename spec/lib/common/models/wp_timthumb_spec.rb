# encoding: UTF-8

require 'spec_helper'

describe WpTimthumb do
  it_behaves_like 'WpTimthumb::Existable'

  subject(:wp_timthumb) { WpTimthumb.new(uri, options) }
  let(:uri)             { URI.parse('http://example.com/') }
  let(:options)         { {} }

end
