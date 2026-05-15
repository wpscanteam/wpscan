# frozen_string_literal: true

describe WPScan::DB::DynamicFinders::Wordpress do
  subject(:dynamic_finders) { described_class }

  describe '.df_data' do
    it 'returns wordpress data from all_df_data' do
      expect(subject.df_data).to be_a Hash
      # Should access 'wordpress' key instead of 'plugins' or 'themes'
      expect(subject.df_data).to eq(subject.all_df_data['wordpress'] || {})
    end
  end

  describe '.version_finder_module' do
    it 'returns Finders::WpVersion' do
      expect(subject.version_finder_module).to eq WPScan::Finders::WpVersion
    end
  end

  describe '.allowed_classes' do
    it 'returns the WordPress-specific allowed classes' do
      expected_classes = %i[
        Comment Xpath HeaderPattern BodyPattern JavascriptVar QueryParameter WpItemQueryParameter
      ]
      expect(subject.allowed_classes).to eq expected_classes
    end
  end

  describe '.finder_configs' do
    context 'when the given class is not allowed' do
      it 'returns an empty hash' do
        expect(subject.finder_configs(:NotAllowed)).to eql({})
      end
    end

    context 'when the given class is allowed' do
      # These tests depend on the actual data in the database
      # Just verify the method works without errors
      it 'returns configs for passive finders' do
        expect(subject.finder_configs(:Comment)).to be_a Hash
      end

      it 'returns configs for aggressive finders' do
        expect(subject.finder_configs(:Xpath, aggressive: true)).to be_a Hash
      end
    end
  end

  describe '.versions_finders_configs' do
    it 'returns configs with version key' do
      expect(subject.versions_finders_configs).to be_a Hash
      # Each config should have 'version' key
      subject.versions_finders_configs.each_value do |config|
        expect(config).to have_key('version')
      end
    end
  end
end
