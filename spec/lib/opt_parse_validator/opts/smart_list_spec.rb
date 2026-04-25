# frozen_string_literal: true

describe OptParseValidator::OptSmartList do
  subject(:opt) { described_class.new(['-l', '--list ARG'], attrs) }
  let(:attrs)   { {} }

  describe '#append_help_messages' do
    let(:expected) { ["Examples: 'a1', '#{%w[a1 a2 a3].join(opt.separator)}', '/tmp/a.txt'"] }

    context 'when no attributes' do
      its(:help_messages) { should eql expected }
    end

    context 'when :default attribute' do
      let(:attrs) { super().merge(default: 'bb') }

      its(:help_messages) { should eql ['Default: bb'] + expected }
    end
  end

  describe '#validate' do
    context 'when just a word' do
      it 'returns the expected array' do
        expect(opt.validate('aa')).to eql %w[aa]
      end
    end

    context 'when multiple words separated' do
      context 'with the correct separator' do
        it 'returns the expected array' do
          expect(opt.validate('aa,bb,cc')).to eql %w[aa bb cc]
        end
      end

      context 'with the wrong separator' do
        it 'is assumed as a word' do
          expect(opt.validate('aa:bb')).to eql %w[aa:bb]
        end
      end
    end

    context 'when a file path' do
      let(:path) { OPV_FIXTURES.join('smart_list.txt') }

      context 'when the file exists and is readable' do
        it 'returns the correct array' do
          expect(opt.validate(path)).to eql %w[aaa bb ccc]
        end
      end

      context 'when the file exists but is not readable' do
        it 'raises an error' do
          allow(File).to receive(:open).and_raise(Errno::EACCES)

          expect { opt.validate(path) }.to raise_error Errno::EACCES
        end
      end

      context 'when the file does not exist' do
        let(:path) { "#{super()}.aa" }

        it 'is assumed as a word' do
          expect(opt.validate(path)).to eql [path]
        end
      end
    end

    context 'when a very long comma-separated list' do
      let(:long_list) do
        'wordpress-seo,jetpack,contact-form-7,woocommerce,elementor,wordfence,wp-super-cache,' \
          'wp-mail-smtp,duplicate-post,classic-editor,akismet,google-analytics-for-wordpress,' \
          'all-in-one-seo-pack,really-simple-ssl,wpforms-lite,updraftplus,wp-optimize,smush,' \
          'redirection,w3-total-cache,loginizer,limit-login-attempts-reloaded'
      end

      it 'should not raise Errno::ENAMETOOLONG' do
        expect { opt.validate(long_list) }.not_to raise_error
      end

      it 'returns the expected array' do
        expected = %w[
          wordpress-seo jetpack contact-form-7 woocommerce elementor wordfence wp-super-cache
          wp-mail-smtp duplicate-post classic-editor akismet google-analytics-for-wordpress
          all-in-one-seo-pack really-simple-ssl wpforms-lite updraftplus wp-optimize smush
          redirection w3-total-cache loginizer limit-login-attempts-reloaded
        ]
        expect(opt.validate(long_list)).to eql expected
      end
    end
  end
end
