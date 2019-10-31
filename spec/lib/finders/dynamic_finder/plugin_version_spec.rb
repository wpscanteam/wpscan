# frozen_string_literal: true

# All Plugin Dynamic Finders returning a Version are tested here.
# When adding one to the spec/fixtures/db/dynamic_finder.yml, a few files have
# to be edited/created
#
# - spec/fixtures/dynamic_finder/expected.yml with the expected result/s
# - Then, depending on the finder class used: spec/fixtures/dynamic_finder/plugin_version/
#
# Furthermore, the fixtures files _passive_all.html are also used by plugins/themes
# finders in spec/app/finders/plugins|themes to check the items existence from the homepage
#
# In case of a failure, it's recommended to use rspec -e "<Full Description>" while fixing.
# e.g: rspec -e "WPScan::Finders::PluginVersion::Cardealerpress::HeaderPattern#passive"
# The -e option can also be used to test all HeaderPattern, for example: rspec -e "::HeaderPattern"

expected_all = df_expected_all['plugins']

WPScan::DB::DynamicFinders::Plugin.versions_finders_configs.each do |slug, configs|
  WPScan::DB::DynamicFinders::Plugin.create_versions_finders(slug)

  configs.each do |finder_class, config|
    finder_super_class = config['class'] || finder_class

    # The QueryParameter specs are slow given the huge fixture file
    # If someone find a fix for that, please share!
    describe df_tested_class_constant('PluginVersion', finder_class, slug), slow: true do
      subject(:finder) { described_class.new(plugin) }
      let(:plugin)     { WPScan::Model::Plugin.new(slug, target) }
      let(:target)     { WPScan::Target.new('http://wp.lab/') }
      let(:fixtures)   { DYNAMIC_FINDERS_FIXTURES.join('plugin_version') }

      let(:expected) do
        if expected_all[slug][finder_class].is_a?(Hash)
          [expected_all[slug][finder_class]]
        else
          expected_all[slug][finder_class]
        end
      end

      before { allow(target).to receive(:content_dir).and_return('wp-content') }

      describe '#passive', slow: true do
        before do
          if defined?(stubbed_homepage_res)
            stub_request(:get, target.url).to_return(stubbed_homepage_res)
          else
            stub_request(:get, target.url)
          end

          if defined?(stubbed_404_res)
            stub_request(:get, ERROR_404_URL_PATTERN).to_return(stubbed_404_res)
          else
            stub_request(:get, ERROR_404_URL_PATTERN)
          end
        end

        if config['path']
          context 'when PATH' do
            it 'returns nil' do
              expect(finder.passive).to eql nil
            end
          end
        else
          context 'when no PATH' do
            context 'when the version is detected' do
              context 'from the homepage' do
                let(:ie_url) { target.url }
                let(:stubbed_homepage_res) do
                  df_stubbed_response(
                    fixtures.join("#{finder_super_class.underscore}_passive_all.html"),
                    finder_super_class
                  )
                end

                it 'returns the expected version/s' do
                  found = [*finder.passive]

                  expect(found).to_not be_empty

                  found.each_with_index do |version, index|
                    expected_version = expected.at(index)
                    expected_ie = expected_version['interesting_entries'].map do |ie|
                      ie.gsub(target.url + ',', ie_url + ',')
                    end

                    expect(version).to be_a WPScan::Model::Version
                    expect(version.number).to eql expected_version['number'].to_s
                    expect(version.found_by).to eql expected_version['found_by']
                    expect(version.interesting_entries).to match_array expected_ie

                    expect(version.confidence).to eql expected_version['confidence'] if expected_version['confidence']
                  end
                end
              end

              context 'from the 404' do
                let(:ie_url) { target.error_404_url }
                let(:stubbed_404_res) do
                  df_stubbed_response(
                    fixtures.join("#{finder_super_class.underscore}_passive_all.html"),
                    finder_super_class
                  )
                end

                it 'returns the expected version/s' do
                  found = [*finder.passive]

                  expect(found).to_not be_empty

                  found.each_with_index do |version, index|
                    expected_version = expected.at(index)
                    expected_ie = expected_version['interesting_entries'].map do |ie|
                      ie.gsub(target.url + ',', ie_url + ',')
                    end

                    expect(version).to be_a WPScan::Model::Version
                    expect(version.number).to eql expected_version['number'].to_s
                    expect(version.found_by).to eql expected_version['found_by']
                    expect(version.interesting_entries).to match_array expected_ie

                    expect(version.confidence).to eql expected_version['confidence'] if expected_version['confidence']
                  end
                end
              end
            end

            context 'when the version is not detected' do
              it 'returns nil or an empty array' do
                expect(finder.passive).to eql finder_super_class == 'QueryParameter' ? [] : nil
              end
            end
          end
        end
      end

      describe '#aggressive' do
        let(:fixtures)         { super().join(slug, finder_class.underscore) }
        let(:stubbed_response) { { body: 'aa' } }

        before do
          stub_request(:get, plugin.url(config['path'])).to_return(stubbed_response) if config['path']
        end

        if config['path']
          context 'when the version is detected' do
            let(:stubbed_response) do
              df_stubbed_response(fixtures.join(config['path']), finder_super_class)
            end

            it 'returns the expected version' do
              found = [*finder.aggressive]

              expect(found).to_not be_empty

              found.each_with_index do |version, index|
                expected_version = expected.at(index)

                expect(version).to be_a WPScan::Model::Version
                expect(version.number).to eql expected_version['number'].to_s
                expect(version.found_by).to eql expected_version['found_by']
                expect(version.interesting_entries).to match_array expected_version['interesting_entries']

                expect(version.confidence).to eql expected_version['confidence'] if expected_version['confidence']
              end
            end
          end

          context 'when the version is not detected' do
            it 'returns nil or an empty array' do
              expect(finder.aggressive).to eql finder_super_class == 'QueryParameter' ? [] : nil
            end
          end
        else
          it 'returns nil' do
            expect(finder.aggressive).to eql nil
          end
        end
      end
    end
  end
end
