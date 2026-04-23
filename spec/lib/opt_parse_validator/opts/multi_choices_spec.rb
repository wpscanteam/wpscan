# frozen_string_literal: true

describe OptParseValidator::OptMultiChoices do
  subject(:opt) { described_class.new(['--enumerate [CHOICES]'], attrs) }
  let(:attrs) do
    {
      choices: {
        vp: OptParseValidator::OptBoolean.new(['--vulnerable-plugins']),
        ap: OptParseValidator::OptBoolean.new(['--all-plugins']),
        p: OptParseValidator::OptBoolean.new(['--plugins']),
        vt: OptParseValidator::OptBoolean.new(['--vulnerable-themes']),
        at: OptParseValidator::OptBoolean.new(['--all-themes']),
        t: OptParseValidator::OptBoolean.new(['--themes', 'Themes Spec']),
        tt: OptParseValidator::OptBoolean.new(['--timthumbs']),
        dbe: OptParseValidator::OptBoolean.new(['--db-exports']),
        u: OptParseValidator::OptIntegerRange.new(['--users', 'User ids Range, e.g: u1-20, u'], value_if_empty: '1-10'),
        m: OptParseValidator::OptIntegerRange.new(['--media'], value_if_empty: '1-100')
      },
      incompatible: [%i[ap vp p], %i[vt at t]]
    }
  end

  describe '#new' do
    context 'when no choices attribute' do
      let(:attrs) { {} }

      it 'raises an error' do
        expect { opt }.to raise_error(OptParseValidator::Error, 'The :choices attribute is mandatory')
      end
    end

    context 'when choices attribute' do
      context 'when not a hash' do
        let(:attrs) { { choices: 'invalid' } }

        it 'raises an error' do
          expect { opt }.to raise_error(OptParseValidator::Error, 'The :choices attribute must be a hash')
        end
      end

      context 'when a hash' do
        it 'does not raise any error' do
          expect { opt }.to_not raise_error
        end
      end
    end
  end

  describe '#append_help_messages' do
    let(:attrs) { super().merge(value_if_empty: 'vp,vt,tt,u,m') }

    its(:help_messages) { should match_array File.readlines(OPV_FIXTURES.join('multi_choices.txt')).map(&:chomp) }

    context 'when default' do
      let(:attrs) { super().merge(default: { all_plugins: true, users: (1..5) }) }

      its(:help_messages) do
        should match_array File.readlines(OPV_FIXTURES.join('multi_choices_w_default.txt')).map(&:chomp)
      end
    end
  end

  describe '#validate' do
    context 'when an unknown choice is given' do
      it 'raises an error' do
        expect { opt.validate('vp,n') }.to raise_error(OptParseValidator::Error, 'Unknown choice: n')
      end
    end

    context 'when nil or empty value' do
      context 'when no value_if_empty attribute' do
        it 'raises an error' do
          [nil, ''].each do |value|
            expect { opt.validate(value) }.to raise_error(OptParseValidator::Error, 'Empty option value supplied')
          end
        end
      end

      context 'when value_if_empty attribute' do
        let(:attrs) { super().merge(value_if_empty: 'vp,u') }

        it 'returns the expected hash' do
          [nil, ''].each do |value|
            expect(opt.validate(value)).to eql(vulnerable_plugins: true, users: (1..10))
          end
        end
      end
    end

    context 'when value' do
      it 'returns the expected hash' do
        expect(opt.validate('u2-5')).to eql(users: (2..5))
      end

      context 'when incompatible choices given' do
        it 'raises an error' do
          {
            'ap,p,t' => 'ap, p',
            'ap,t,vp' => 'ap, vp',
            'ap,at,t' => 'at, t'
          }.each do |value, msg|
            expect do
              opt.validate(value)
            end.to raise_error(OptParseValidator::Error, "Incompatible choices detected: #{msg}")
          end
        end
      end
    end
  end

  describe '#normalize' do
    it 'returns the same value (no normalization)' do
      expect(opt.normalize('a')).to eql 'a'
    end
  end
end
