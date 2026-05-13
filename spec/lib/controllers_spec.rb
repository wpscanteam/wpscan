# frozen_string_literal: true

module WPScan
  module Controller
    class Spec < Base
      def before_scan
        output('help', help: option_parser.simple_help, simple: true) if WPScan::ParsedCli.help

        exit(WPScan::ExitCode::OK) if WPScan::ParsedCli.help
      end
    end

    class SpecTooLong < Spec
      def run
        sleep(2)
      end
    end
  end
end

describe WPScan::Controllers do
  subject(:controllers)  { described_class.new }
  let(:controller_mod) { WPScan::Controller }

  its(:'option_parser.config_files.result_key') { should eql 'cli_options' }

  describe '#<<' do
    its(:size) { should be 0 }

    context 'when controllers are added' do
      before { controllers << controller_mod::Spec.new << controller_mod::Base.new }

      its(:size) { should be 2 }
    end

    context 'when a controller is added twice' do
      before { 2.times { controllers << controller_mod::Spec.new } }

      its(:size) { should be 1 }
    end

    it 'returns self' do
      expect(controllers << controller_mod::Spec.new).to be_a described_class
    end
  end

  describe '#run' do
    let(:hydra) { WPScan::Browser.instance.hydra }

    it 'runs the before_scan, run and after_scan methods of each controller' do
      spec = controller_mod::Spec.new
      base = controller_mod::Base.new

      controllers << base << spec

      expect(controllers.option_parser).to receive(:results).and_return({})

      [base, spec].each { |c| expect(c).to receive(:before_scan).ordered }
      [base, spec].each { |c| expect(c).to receive(:run).ordered } # rubocop:disable Style/CombinableLoops

      expect_any_instance_of(Typhoeus::Hydra).to receive(:abort)

      [spec, base].each { |c| expect(c).to receive(:after_scan).ordered }

      controllers.run
    end

    context 'when just calling --help' do
      before { controllers << controller_mod::Spec.new }

      it 'does no call #run and #after_scan on the controllers' do
        expect(controllers.option_parser).to receive(:results).and_return(help: true)

        controllers.each do |c|
          expect(c).to_not receive(:run)
          expect(c).to_not receive(:after_scan)
        end

        expect(controllers.first.formatter).to receive(:output)
          .ordered
          .with('help', hash_including(:help, :simple), 'spec')

        expect_any_instance_of(Typhoeus::Hydra).to receive(:abort)

        expect { controllers.run }.to raise_error(SystemExit)
      end
    end

    context 'when max_scan_duration is provided' do
      before do
        expect(controllers.option_parser).to receive(:results)
          .and_return(max_scan_duration: max_scan_duration)

        controllers << controller_mod::Spec.new << controller_mod::SpecTooLong.new
      end

      context 'when the scan exceeds the max duration' do
        let(:max_scan_duration) { 1 }

        it 'raises an exception' do
          expect_any_instance_of(Typhoeus::Hydra).to receive(:abort)

          controllers.reverse_each { |c| expect(c).to receive(:after_scan).ordered }

          expect { controllers.run }.to raise_error(WPScan::Error::MaxScanDurationReached)
        end
      end

      context 'when the scan does not exceed to max duration' do
        let(:max_scan_duration) { 4 }

        it 'does not raise an exception' do
          expect { controllers.run }.to_not raise_error
        end
      end
    end

    context 'when an error is raised by abort' do
      it 'ignores it and runs the after_scan methods of each controller' do
        spec = controller_mod::Spec.new
        base = controller_mod::Base.new

        controllers << base << spec

        expect(controllers.option_parser).to receive(:results).and_return({})

        [base, spec].each { |c| expect(c).to receive(:before_scan).ordered }
        [base, spec].each { |c| expect(c).to receive(:run).ordered } # rubocop:disable Style/CombinableLoops

        expect_any_instance_of(Typhoeus::Hydra).to receive(:abort).and_raise('Should be Ignored')

        [spec, base].each { |c| expect(c).to receive(:after_scan).ordered }

        controllers.run
      end
    end
  end

  describe '#apply_no_colour_default' do
    let(:no_color) { nil }

    before do
      ENV['NO_COLOR'] = no_color
      allow($stdout).to receive(:tty?).and_return(tty)
    end

    after { ENV.delete('NO_COLOR') }

    let(:tty) { true }

    def options_after(opts)
      WPScan::ParsedCli.options = opts
      controllers.send(:apply_no_colour_default)
      WPScan::ParsedCli.options
    end

    context 'when --output is set' do
      it 'forces cli-no-colour' do
        expect(options_after(output: '/tmp/out.txt')[:format]).to eql 'cli-no-colour'
      end

      it 'preserves an explicit --format' do
        expect(options_after(output: '/tmp/out.txt', format: 'json')[:format]).to eql 'json'
      end
    end

    context 'when stdout is not a TTY' do
      let(:tty) { false }

      it 'forces cli-no-colour' do
        expect(options_after({})[:format]).to eql 'cli-no-colour'
      end
    end

    context 'when NO_COLOR is set' do
      let(:no_color) { '1' }

      it 'forces cli-no-colour' do
        expect(options_after({})[:format]).to eql 'cli-no-colour'
      end
    end

    context 'when NO_COLOR is set but empty' do
      let(:no_color) { '' }

      it 'does not change the format' do
        expect(options_after({})[:format]).to be_nil
      end
    end

    context 'when stdout is a TTY, no --output and no NO_COLOR' do
      it 'does not change the format' do
        expect(options_after({})[:format]).to be_nil
      end
    end
  end

  describe '#register_config_files' do
    it 'register the correct files' do
      expect(File).to receive(:exist?).exactly(4).times.and_return(true)

      expected = []
      option_parser = controllers.option_parser

      [Dir.home, Dir.pwd].each do |dir|
        option_parser.config_files.class.supported_extensions.each do |ext|
          expected << File.join(dir, '.wpscan', "scan.#{ext}")
        end
      end

      expect(option_parser.config_files.map(&:path)).to eql expected
    end
  end
end
