# frozen_string_literal: true

describe OptParseValidator::OptProxy do
  subject(:opt) { described_class.new(['--proxy PROXY'], attrs) }
  let(:attrs)   { { protocols: %w[http https socks socks5 socks4] } }

  describe '#validate' do
    # Handled by OptURI
  end
end
