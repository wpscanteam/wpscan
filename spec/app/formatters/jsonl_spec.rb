# frozen_string_literal: true

describe WPScan::Formatter::Jsonl do
  subject(:formatter) { described_class.new }

  before { formatter.views_directories << FIXTURES_VIEWS }

  its(:format)            { should eq 'jsonl' }
  its(:base_format)       { should eq 'json' }
  its(:user_interaction?) { should be false }

  describe '#beautify' do
    it 'is a no-op (lines are already final)' do
      expect { formatter.beautify }.not_to output.to_stdout
    end
  end

  describe '#output' do
    it 'writes one JSON object per render, immediately, per call' do
      expect do
        2.times { formatter.output('@render_me', test: 'Working') }
      end.to output("{\"test\":\"Working\"}\n" * 2).to_stdout
    end

    it 'keeps all keys from a single render together on one line' do
      expect do
        formatter.output('@render_me', test: 'a', var: 'b')
      end.to output("{\"test\":\"a\",\"var\":\"b\"}\n").to_stdout
    end

    it 'skips empty renders' do
      empty_tpl = FIXTURES_VIEWS.join('json', 'empty.erb')
      File.write(empty_tpl, '')
      begin
        expect { formatter.output('@empty') }.not_to output.to_stdout
      ensure
        File.delete(empty_tpl)
      end
    end

    context 'when invalid UTF-8 chars' do
      it 'tries to convert/replace them' do
        replacement = '�'
        expected = "{\"test\":\"#{replacement}it#{replacement}s\"}\n"

        expect do
          formatter.output('@render_me', test: "\x93it\x92s".dup.force_encoding('CP1252'))
        end.to output(expected).to_stdout
      end
    end
  end
end
