# frozen_string_literal: true

describe OptParseValidator::OptURI do
  subject(:opt) { described_class.new(['-u', '--uri URI'], attrs) }
  let(:attrs)   { {} }

  describe '#new, #allowed_protocols' do
    context 'when no attrs supplied' do
      its(:allowed_protocols) { should be_empty }
      its(:default_protocol) { should be nil }
    end

    context 'when only one protocol supplied' do
      let(:attrs) { { protocols: 'http' } }

      it 'sets it' do
        opt.allowed_protocols << 'ftp'
        expect(opt.allowed_protocols).to eq %w[http ftp]
      end
    end

    context 'when multiple protocols are given' do
      let(:attrs) { { protocols: %w[ftp https] } }

      it 'sets them' do
        expect(opt.allowed_protocols).to eq attrs[:protocols]
      end
    end

    context 'when uppercase protocols' do
      let(:attrs) { { protocols: %w[ftp HTTPS] } }

      its(:allowed_protocols) { should eq %w[ftp https] }
    end
  end

  describe '#append_help_messages' do
    context 'when no :default_protocol and :allowed_protocols attribute' do
      its(:help_messages) { should eql([]) }
    end

    context 'when :default_protocol attribute' do
      let(:attrs) { super().merge(default_protocol: 'http') }

      its(:help_messages) { should eql ['Default Protocol if none provided: http'] }

      context 'when :default_protocol attribute is uppercase' do
        let(:attrs) { super().merge(default_protocol: 'HTTPS') }

        its(:help_messages) { should eql ['Default Protocol if none provided: https'] }
      end
    end

    context 'when :allowed_protocols attribute' do
      let(:attrs) { super().merge(protocols: %w[http https]) }

      its(:help_messages) { should eql ['Allowed Protocols: http, https'] }
    end

    context 'when :allowed_protocols and :default attributes' do
      let(:attrs) { super().merge(protocols: %w[http https], default: 'https://t.org') }

      its(:help_messages) { should eql ['Allowed Protocols: http, https', 'Default: https://t.org'] }
    end
  end

  describe '#validate' do
    context 'when allowed_protocols is empty' do
      it 'accepts all protocols' do
        %w[http ftp file].each do |p|
          expected = "#{p}://testing"

          expect(opt.validate(expected)).to eq expected
        end
      end
    end

    context 'when allowed_protocols is set' do
      let(:attrs) { { protocols: %w[https] } }

      it 'raises an error if the protocol is not allowed' do
        expect { opt.validate('ftp://ishouldnotbethere') }
          .to raise_error(Addressable::URI::InvalidURIError)
      end

      it 'returns the uri string if valid' do
        expected = 'https://example.com/'

        expect(opt.validate(expected)).to eq expected
      end

      it 'does not raise an error when scheme is upperacse' do
        expected = 'HTTPS://example.com/'

        expect(opt.validate(expected)).to eq expected
      end
    end

    context 'when default_protocol' do
      let(:attrs) { { default_protocol: 'ftp' } }

      context 'when the argument already contains a protocol' do
        it 'does not add the default protocol' do
          expect(opt.validate('http://ex.lo')).to eq 'http://ex.lo'
        end
      end

      context 'when no protocol given in the argument' do
        it 'adds it' do
          expect(opt.validate('ex.lo')).to eq 'ftp://ex.lo'
        end
      end
    end
  end
end
