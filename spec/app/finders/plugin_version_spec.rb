# frozen_string_literal: true

describe WPScan::Finders::PluginVersion::Base do
  subject(:plugin_version) { described_class.new(plugin) }
  let(:plugin)             { WPScan::Model::Plugin.new(slug, target) }
  let(:target)             { WPScan::Target.new('http://wp.lab/') }
  let(:default_finders)    { %w[Readme] }

  describe '#finders' do
    after do
      expect(target).to receive(:content_dir).and_return('wp-content')
      expect(plugin_version.finders.map { |f| f.class.to_s.demodulize }).to match_array @expected
    end

    context 'when no related dynamic finders' do
      let(:slug) { 'spec' }

      it 'contains the default finders' do
        @expected = default_finders
      end
    end

    # Dynamic Version Finders are not tested here, they are in
    # spec/lib/finders/dynamic_finder/plugin_versions_spec
    context 'when dynamic finders' do
      WPScan::DB::DynamicFinders::Plugin.versions_finders_configs.each do |plugin_slug, configs|
        context "when #{plugin_slug} plugin" do
          let(:slug) { plugin_slug }

          it 'contains the expected finders (default + the dynamic ones)' do
            @expected = default_finders + configs.keys
          end
        end
      end
    end
  end
end
