# frozen_string_literal: true

describe WPScan::DB::DynamicFinders::Theme do
  subject(:dynamic_finders) { described_class }

  # Most of it is done in the Plugin specs
  # These tests verify Theme-specific behavior

  describe '.df_data' do
    it 'returns themes data from all_df_data' do
      expect(subject.df_data).to be_a Hash
      # Should access 'themes' key instead of 'plugins'
      expect(subject.df_data).to eq(subject.all_df_data['themes'] || {})
    end
  end

  describe '.version_finder_module' do
    it 'returns Finders::ThemeVersion' do
      expect(subject.version_finder_module).to eq WPScan::Finders::ThemeVersion
    end
  end

  describe '.maybe_create_module' do
    let(:slug) { 'test-theme' }
    let(:module_name) { :TestTheme }

    after do
      # Clean up created modules after each test
      if WPScan::Finders::ThemeVersion.const_defined?(module_name, false)
        WPScan::Finders::ThemeVersion.send(:remove_const, module_name)
      end
    end

    it 'creates modules in Finders::ThemeVersion instead of PluginVersion' do
      expect(WPScan::Finders::ThemeVersion.const_defined?(module_name, false)).to be false

      result = subject.maybe_create_module(slug)

      expect(result).to be_a Module
      expect(WPScan::Finders::ThemeVersion.const_defined?(module_name, false)).to be true
      expect(WPScan::Finders::ThemeVersion.const_get(module_name)).to eq result
    end
  end
end
