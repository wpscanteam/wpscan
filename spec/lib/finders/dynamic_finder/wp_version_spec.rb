# frozen_string_literal: true

expected_all = df_expected_all['wordpress']

WPScan::DB::DynamicFinders::Wordpress.create_versions_finders

describe 'Try to create the finders twice' do
  it 'does not raise an error when the class already exists' do
    expect { WPScan::DB::DynamicFinders::Wordpress.create_versions_finders }.to_not raise_error
  end
end

WPScan::DB::DynamicFinders::Wordpress.versions_finders_configs.each do |finder_class, config|
  finder_super_class = config['class'] || finder_class

  describe df_tested_class_constant('WpVersion', finder_class) do
    subject(:finder) { described_class.new(target) }
    let(:target)     { WPScan::Target.new('http://wp.lab/') }
    let(:fixtures)   { DYNAMIC_FINDERS_FIXTURES.join('wp_version') }

    let(:expected) do
      expected_all[finder_class].is_a?(Hash) ? [expected_all[finder_class]] : expected_all[finder_class]
    end

    let(:stubbed_response) { { body: '' } }

    describe '#passive' do
      before do
        stub_request(:get, target.url).to_return(stubbed_response)
        stub_request(:get, ERROR_404_URL_PATTERN)
      end

      if config['path']
        context 'when PATH' do
          it 'returns nil' do
            expect(finder.passive).to eql nil
          end
        end
      else
        context 'when no PATH' do
          let(:stubbed_response) do
            df_stubbed_response(
              fixtures.join("#{finder_super_class.underscore}_passive_all.html"),
              finder_super_class
            )
          end

          it 'returns the expected version from the homepage' do
            found = [*finder.passive]

            expect(found).to_not be_empty

            found.each_with_index do |version, index|
              expected_version = expected.at(index)

              expect(version).to be_a WPScan::Model::WpVersion
              expect(version.number).to eql expected_version['number'].to_s
              expect(version.found_by).to eql expected_version['found_by']
              expect(version.interesting_entries).to match_array expected_version['interesting_entries']

              expect(version.confidence).to eql expected_version['confidence'] if expected_version['confidence']
            end
          end
        end
      end
    end

    describe '#aggressive' do
      let(:fixtures) { super().join(finder_class.underscore) }

      before do
        allow(target).to receive(:sub_dir).and_return(false)

        stub_request(:get, target.url(config['path'])).to_return(stubbed_response) if config['path']
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

              expect(version).to be_a WPScan::Model::WpVersion
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
