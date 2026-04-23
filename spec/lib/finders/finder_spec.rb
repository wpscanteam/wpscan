# frozen_string_literal: true

describe WPScan::Finders::Finder do
  subject(:finder) { described_class.new('target') }

  its(:titleize) { should eql 'Finder' }
  its(:browser)  { should be_a WPScan::Browser }
  its(:hydra)    { should be_a Typhoeus::Hydra }

  describe '#create_progress_bar' do
    before { finder.create_progress_bar(opts) }

    context 'when opts[:show_progression] is true' do
      let(:opts) { { show_progression: true } }

      it 'uses the default progress-bar output' do
        output = finder.progress_bar.send(:output)
        expect(output).to be_a(ProgressBar::Outputs::Tty).or be_a(ProgressBar::Outputs::NonTty)
      end
    end

    context 'when opts[:show_progression] is false' do
      let(:opts) { { show_progression: false } }

      it 'uses the null progress_bar outout' do
        expect(finder.progress_bar.send(:output)).to be_a ProgressBar::Outputs::Null
      end

      context 'when logging data' do
        context 'when no logs' do
          it 'returns an empty array' do
            expect(finder.progress_bar.log).to eql([])
          end
        end

        context 'when adding messages' do
          it 'returns the messages' do
            finder.progress_bar.log 'Hello'
            finder.progress_bar.log 'World'

            expect(finder.progress_bar.log).to eql(%w[Hello World])
          end
        end
      end
    end
  end

  class SpecCallerLocation
    attr_reader :call

    def initialize(call)
      @call = call
    end

    def label
      @label ||= call[/`([^']+)'$/, 1]
    end

    def to_s
      call
    end
  end

  describe '#found_by' do
    context 'when no klass supplied' do
      context 'when no passive or aggresive match' do
        it 'returns nil' do
          expect(finder).to receive(:caller_locations).and_return([])

          expect(finder.found_by).to be_nil
        end
      end

      context 'when aggressive match' do
        it 'returns the expected string' do
          expect(finder).to receive(:caller_locations)
            .and_return([SpecCallerLocation.new("/aaaaa/file.rb:xx:in `aggressive'")])

          expect(finder.found_by).to eql 'Finder (Aggressive Detection)'
        end
      end
    end

    {
      Rspec: 'Rspec', Error404Page: 'Error 404 Page',
      CssId: 'Css Id', Something12Db2: 'Something 12 Db2'
    }.each do |klass, expected_title|
      context "when class #{klass} supplied" do
        it 'returns the expected string' do
          allow(finder).to receive(:caller_locations)
            .and_return([SpecCallerLocation.new("/aaaaa/file.rb:xx:in `passive'")])

          expected = "#{expected_title} (Passive Detection)"

          expect(finder.found_by(klass)).to eql expected
        end
      end
    end
  end
end
