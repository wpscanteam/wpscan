# encoding: UTF-8

require 'spec_helper'

describe WpUsers do
  it_behaves_like 'WpUsers::BruteForcable'

  subject(:wp_users) { WpUsers.new }
  let(:url)          { 'http://example.com/' }
  let(:uri)          { URI.parse(url) }
end
