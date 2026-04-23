# frozen_string_literal: true

describe OptParseValidator do
  it 'returns the version' do
    expect(OptParseValidator::VERSION).to be >= '0'
  end
end
