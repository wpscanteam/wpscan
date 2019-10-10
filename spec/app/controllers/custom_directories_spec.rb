# frozen_string_literal: true

describe WPScan::Controller::CustomDirectories do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://ex.lo/' }
  let(:cli_args)       { "--url #{target_url}" }

  before do
    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
  end

  describe '#cli_options' do
    its(:cli_options) { should_not be_empty }
    its(:cli_options) { should be_a Array }

    it 'contains to correct options' do
      expect(controller.cli_options.map(&:to_sym)).to eq %i[wp_content_dir wp_plugins_dir]
    end
  end

  describe '#before_scan' do
    context 'when the content_dir is not found and not supplied' do
      before { expect(controller.target).to receive(:content_dir).and_return(nil) }

      it 'raises an exception' do
        expect { controller.before_scan }.to raise_error(WPScan::Error::WpContentDirNotDetected)
      end
    end

    context 'when content_dir found/supplied' do
      let(:cli_args) { "#{super()} --wp-content-dir wp-content" }

      it 'does not raise any error' do
        expect { controller.before_scan }.to_not raise_error
        expect(controller.target.content_dir).to eq WPScan::ParsedCli.wp_content_dir
      end
    end
  end
end
