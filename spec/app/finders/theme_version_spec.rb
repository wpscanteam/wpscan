# frozen_string_literal: true

describe WPScan::Finders::ThemeVersion::Base do
  subject(:theme_version) { described_class.new(theme) }
  let(:theme)             { WPScan::Model::Plugin.new(slug, target) }
  let(:target)            { WPScan::Target.new('http://wp.lab/') }
  let(:slug)              { 'spec' }
  let(:default_finders)   { %w[Style WooFrameworkMetaGenerator] }

  describe '#finders' do
    after do
      expect(target).to receive(:content_dir).and_return('wp-content')
      expect(theme_version.finders.map { |f| f.class.to_s.demodulize }).to eql @expected
    end

    context 'when no related specific finders' do
      it 'contains the default finders' do
        @expected = default_finders
      end
    end

    context 'when specific finders' do
      {
      }.each do |theme_slug, specific_finders|
        context "when #{theme_slug} theme" do
          let(:slug) { theme_slug }

          it 'contains the expected finders' do
            @expected = default_finders + specific_finders
          end
        end
      end
    end
  end
end
