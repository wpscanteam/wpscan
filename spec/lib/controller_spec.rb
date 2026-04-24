# frozen_string_literal: true

describe WPScan::Controller do
  subject(:controller) { described_class::Base.new }

  before do
    described_class::Base.reset
    described_class::Base.option_parser = nil

    WPScan::ParsedCli.options = parsed_options
  end

  let(:parsed_options) { { url: 'http://example.com/' } }

  its(:option_parser)         { should be nil }
  its(:formatter)             { should be_a WPScan::Formatter::Cli }
  its(:user_interaction?)     { should be true }
  its(:target)                { should be_a WPScan::Target }
  its('target.scope.domains') { should eq [PublicSuffix.parse('example.com')] }

  describe '#tmp_directory' do
    context 'when TMPDIR is not set' do
      before { stub_const('ENV', ENV.to_hash.tap { |e| e.delete('TMPDIR') }) }

      its(:tmp_directory) { should eql '/tmp/wpscan' }
    end

    context 'when TMPDIR is set' do
      before { stub_const('ENV', ENV.to_hash.merge('TMPDIR' => '/home/user/tmp')) }

      its(:tmp_directory) { should eql '/home/user/tmp/wpscan' }
    end
  end

  context 'when output option' do
    let(:parsed_options) { super().merge(output: '/tmp/spec.txt') }

    its(:user_interaction?) { should be false }
  end

  describe '#render' do
    it 'calls the formatter#render' do
      expect(controller.formatter).to receive(:render).with('test', { verbose: nil }, 'base')
      controller.render('test')
    end
  end
end
