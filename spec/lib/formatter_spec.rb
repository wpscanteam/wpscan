# frozen_string_literal: true

module WPScan
  module Formatter
    module Spec
      # Base Format Test Class
      class BasedFormat < Base
        def base_format
          'base'
        end
      end
    end
  end
end

describe WPScan::Formatter::Base do
  subject(:formatter) { described_class.new }

  describe '#format' do
    its(:format) { should eq 'base' }
  end

  describe '#user_interaction?' do
    context 'when not a cli format' do
      its(:user_interaction?) { should be false }
    end

    context 'when a cli format' do
      before { expect(formatter).to receive(:format).and_return('cli') }

      its(:user_interaction?) { should be true }
    end
  end

  describe '#render, output' do
    before { formatter.views_directories << FIXTURES_VIEWS }

    it 'renders the global template and does not override the @views_directories' do
      expect($stdout).to receive(:puts)
        .with("It Works!\nViews Dirs: #{formatter.views_directories}")

      formatter.output('@test', test: 'Works!', views_directories: 'owned')
    end

    context 'when global and local rendering are used inside a template' do
      it 'renders them correcly' do
        rendered = formatter.render('test', { var: 'Works' }, 'ctrl')

        expect(rendered).to eq "Test: Works\nLocal View\nGlobal View"
      end
    end

    it 'raises an error if the controller_name is nil and tpl is not a global one' do
      expect { formatter.output('test') }.to raise_error('The controller_name can not be nil')
    end
  end

  describe '#view_path' do
    before do
      formatter.views_directories << FIXTURES_VIEWS
      formatter.render('local', {}, 'ctrl')
    end

    context 'when the tpl format is invalid' do
      let(:tpl) { '../try-this' }

      it 'raises an error' do
        expect { formatter.view_path(tpl) }.to raise_error("Wrong tpl format: 'ctrl/#{tpl}'")
      end
    end

    context 'when the tpl is not found' do
      let(:tpl) { 'not_there' }

      it 'raises an error' do
        expect { formatter.view_path(tpl) }.to raise_error("View not found for base/ctrl/#{tpl}")
      end
    end

    context 'when the tpl is found' do
      after { expect(formatter.view_path(@tpl)).to eq @expected.to_s }

      context 'if it\'s a global tpl' do
        it 'returns its path' do
          @expected = FIXTURES_VIEWS.join('base', 'test.erb')
          @tpl      = '@test'
        end
      end

      context 'if it\s a local tpl' do
        it 'retuns its path' do
          @expected = FIXTURES_VIEWS.join('base', 'ctrl', 'local.erb')
          @tpl      = 'local'
        end
      end
    end

    context 'when base_format' do
      subject(:formatter) { WPScan::Formatter::Spec::BasedFormat.new }

      after { expect(formatter.view_path(@tpl)).to eq @expected.to_s }

      context 'when the ovverided view exists' do
        it 'returns it' do
          @expected = FIXTURES_VIEWS.join('based_format', 'test.erb')
          @tpl      = '@test'
        end
      end

      it 'returns the base views otherwise' do
        @expected = FIXTURES_VIEWS.join('base', 'ctrl', 'local.erb')
        @tpl      = 'local'
      end
    end
  end

  describe '#views_directories' do
    let(:default_directories) do
      [Dir.home, Dir.pwd].reduce([APP_VIEWS]) do |a, e|
        a << Pathname.new(e).join(".#{WPScan.app_name}", 'views').to_s
      end
    end

    context 'when default directories' do
      its(:views_directories) { should eq(default_directories) }
    end

    context 'when adding directories' do
      it 'adds them' do
        formatter.views_directories << 'testing'

        expect(formatter.views_directories).to eq(default_directories << 'testing')
      end
    end
  end
end
