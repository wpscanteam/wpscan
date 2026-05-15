# frozen_string_literal: true

describe WPScan::Scan do
  subject(:scanner) { described_class.new }
  let(:controller)  { WPScan::Controller }
  let(:target_url)  { 'http://example.com/' }

  before do
    Object.send(:remove_const, :ARGV)
    Object.const_set(:ARGV, [])
  end

  describe '#new, #controllers' do
    its(:controllers) { should eq([controller::Core.new]) }

    it 'sets the WPScan.start_memory' do
      WPScan.start_memory = 0

      described_class.new

      expect(WPScan.start_memory).to be_positive
    end
  end

  describe '#run' do
    after do
      scanner.run

      if defined?(run_error)
        expect(scanner.run_error).to be_a run_error.class
        expect(scanner.run_error.message).to eql run_error.message
      end
    end

    it 'runs the controlllers and calls the formatter#beautify' do
      expect(scanner.controllers).to receive(:run).ordered
      expect(scanner.formatter).to receive(:beautify).ordered
    end

    context 'when no required option supplied' do
      it 'calls the formatter to display the usage view' do
        expect(scanner.formatter).to receive(:output)
          .with('@usage', msg: 'One of the following options is required: --url, --update, --help, --hh, --version')
      end
    end

    context 'when an error is raised by OptParseValidator' do
      it 'aborts the scan with the correct output (ie w/o the url key)' do
        expect(scanner.controllers.option_parser).to receive(:results).and_return({})

        expect(scanner.controllers.first).to receive(:before_scan).and_raise(OptParseValidator::Error, 'cli option')

        expect(scanner.formatter).to receive(:output).with(
          '@scan_aborted',
          { reason: 'cli option', trace: anything, verbose: false }
        )
      end
    end

    context 'when an error is raised while updating the database' do
      it 'aborts with the @update_aborted view' do
        expect(scanner.controllers.option_parser).to receive(:results).and_return({ url: target_url })

        expect(scanner.controllers.first).to receive(:before_scan) do
          scanner.controllers.first.instance_variable_set(:@updating_db, true)
          raise 'connection failed'
        end

        expect(scanner.formatter).to receive(:output).with(
          '@update_aborted',
          { reason: 'connection failed', trace: anything, verbose: true, url: target_url }
        )
      end
    end

    context 'when an Interrupt is raised during the scan' do
      it 'aborts the scan with the correct output' do
        expect(scanner.controllers.option_parser).to receive(:results).and_return({ url: target_url })

        expect(scanner.controllers.first).to receive(:before_scan).and_raise(Interrupt)

        expect(scanner.formatter).to receive(:output).with(
          '@scan_aborted',
          { reason: 'Canceled by User', trace: anything, verbose: false, url: target_url }
        )
      end
    end

    {
      NoMemoryError.new => true,
      ScriptError.new => true,
      SecurityError.new => true,
      SignalException.new('SIGTERM') => true,
      Interrupt.new('Canceled by User') => false,
      RuntimeError.new('error spotted') => true,
      WPScan::Error::Standard.new('aa') => false,
      WPScan::Error::MaxScanDurationReached.new => false,
      SystemStackError.new => true
    }.each do |error, expected_verbose|
      context "when an/a #{error.class} is raised during the scan" do
        let(:run_error) { error }

        it 'aborts the scan with the associated output' do
          expect(scanner.controllers.option_parser).to receive(:results).and_return({ url: target_url })

          expect(scanner.controllers.first)
            .to receive(:before_scan)
            .and_raise(run_error.class, run_error.message)

          expect(scanner.formatter).to receive(:output).with(
            '@scan_aborted',
            { reason: run_error.message, trace: anything, verbose: expected_verbose, url: target_url }
          )
        end
      end
    end
  end

  describe '#datastore' do
    its(:datastore) { should eq({}) }
  end

  describe '#exit_hook' do
    # Cannot test: method explicitly returns early when RSpec is defined to avoid interfering
    # with RSpec's exit code handling. See method comment referencing rspec/rspec-core#410
    xit 'sets up at_exit hook for exit codes'
  end
end
