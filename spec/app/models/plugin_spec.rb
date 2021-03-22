# frozen_string_literal: true

describe WPScan::Model::Plugin do
  subject(:plugin) { described_class.new(slug, blog, opts) }
  let(:slug)       { 'spec' }
  let(:blog)       { WPScan::Target.new('http://wp.lab/') }
  let(:opts)       { {} }

  before { expect(blog).to receive(:content_dir).and_return('wp-content') }

  describe '#new' do
    its(:url) { should eql 'http://wp.lab/wp-content/plugins/spec/' }
  end

  describe '#version' do
    after do
      expect(WPScan::Finders::PluginVersion::Base).to receive(:find).with(plugin, @expected_opts)

      plugin.version(version_opts)
    end

    let(:default_opts) { {} }

    context 'when no :detection_mode' do
      context 'when no :mode opt supplied' do
        let(:version_opts) { { something: 'k' } }

        it 'calls the finder with the correct parameters' do
          @expected_opts = version_opts
        end
      end

      context 'when :mode supplied' do
        let(:version_opts) { { mode: :passive } }

        it 'calls the finder with the correct parameters' do
          @expected_opts = default_opts.merge(mode: :passive)
        end
      end
    end

    context 'when :detection_mode' do
      let(:opts) { super().merge(mode: :passive) }

      context 'when no :mode' do
        let(:version_opts) { {} }

        it 'calls the finder without mode' do
          @expected_opts = version_opts
        end
      end

      context 'when :mode' do
        let(:version_opts) { { mode: :mixed } }

        it 'calls the finder with the :mixed mode' do
          @expected_opts = default_opts.merge(mode: :mixed)
        end
      end
    end
  end

  describe 'potential_readme_filenames' do
    context 'when not set in the DF file' do
      its(:potential_readme_filenames) { should eql described_class::READMES }
    end

    context 'when set in the DF file' do
      context 'as a string' do
        let(:slug) { 'photoblocks-grid-gallery' }

        its(:potential_readme_filenames) { should eql %w[README.txt] }
      end

      context 'as an array' do
        let(:slug) { 'customerlabs-actionrecorder' }

        its(:potential_readme_filenames) { should eql %w[Readme.txt Readme.md] }
      end
    end
  end

  describe '#latest_version, #last_updated, #popular' do
    before { allow(plugin).to receive(:db_data).and_return(db_data) }

    context 'when no db_data and no metadata' do
      let(:slug)    { 'not-known' }
      let(:db_data) { {} }

      its(:latest_version) { should be_nil }
      its(:last_updated) { should be_nil }
      its(:popular?) { should be false }
    end

    context 'when no db_data but metadata' do
      let(:slug) { 'no-vulns-popular' }
      let(:db_data) { {} }

      its(:latest_version) { should eql WPScan::Model::Version.new('2.0') }
      its(:last_updated) { should eql '2015-05-16T00:00:00.000Z' }
      its(:popular?) { should be true }
    end

    context 'when db_data' do
      let(:slug) { 'no-vulns-popular' }
      let(:db_data) { vuln_api_data_for('plugins/no-vulns-popular') }

      its(:latest_version) { should eql WPScan::Model::Version.new('2.1') }
      its(:last_updated) { should eql '2015-05-16T00:00:00.000Z-via-api' }
      its(:popular?) { should be true }
    end
  end

  describe '#outdated?' do
    before { allow(plugin).to receive(:db_data).and_return({}) }

    context 'when last_version' do
      let(:slug) { 'no-vulns-popular' }

      context 'when no version' do
        before { expect(plugin).to receive(:version).at_least(1).and_return(nil) }

        its(:outdated?) { should eql false }
      end

      context 'when version' do
        before do
          expect(plugin)
            .to receive(:version)
            .at_least(1)
            .and_return(WPScan::Model::Version.new(version_number))
        end

        context 'when version < latest_version' do
          let(:version_number) { '1.2' }

          its(:outdated?) { should eql true }
        end

        context 'when version >= latest_version' do
          let(:version_number) { '3.0' }

          its(:outdated?) { should eql false }
        end
      end
    end

    context 'when no latest_version' do
      let(:slug) { 'vulnerable-not-popular' }

      context 'when no version' do
        before { expect(plugin).to receive(:version).at_least(1).and_return(nil) }

        its(:outdated?) { should eql false }
      end

      context 'when version' do
        before do
          expect(plugin)
            .to receive(:version)
            .at_least(1)
            .and_return(WPScan::Model::Version.new('1.0'))
        end

        its(:outdated?) { should eql false }
      end
    end
  end

  describe '#vulnerabilities' do
    before { allow(plugin).to receive(:db_data).and_return(db_data) }

    after do
      expect(plugin.vulnerabilities).to eq @expected
      expect(plugin.vulnerable?).to eql !@expected.empty?
    end

    context 'when plugin not in the DB' do
      let(:slug)    { 'not-in-db' }
      let(:db_data) { {} }

      it 'returns an empty array' do
        @expected = []
      end
    end

    context 'when in the DB' do
      context 'when no vulnerabilities' do
        let(:slug)    { 'no-vulns-popular' }
        let(:db_data) { vuln_api_data_for('plugins/no-vulns-popular') }

        it 'returns an empty array' do
          @expected = []
        end
      end

      context 'when vulnerabilities' do
        context 'when only fixed_in' do
          let(:slug)    { 'vulnerable-not-popular' }
          let(:db_data) { vuln_api_data_for('plugins/vulnerable-not-popular') }

          let(:all_vulns) do
            [
              WPScan::Vulnerability.new(
                'First Vuln <= 6.3.10 - LFI',
                references: { wpvulndb: '1' },
                type: 'LFI',
                fixed_in: '6.3.10'
              ),
              WPScan::Vulnerability.new('No Fixed In', references: { wpvulndb: '2' })
            ]
          end

          context 'when no plugin version' do
            before { expect(plugin).to receive(:version).at_least(1).and_return(false) }

            it 'returns all the vulnerabilities' do
              @expected = all_vulns
            end
          end

          context 'when plugin version' do
            before do
              expect(plugin)
                .to receive(:version)
                .at_least(1)
                .and_return(WPScan::Model::Version.new(number))
            end

            context 'when < to fixed_in' do
              let(:number) { '5.0' }

              it 'returns it' do
                @expected = all_vulns
              end
            end

            context 'when >= to fixed_in' do
              let(:number) { '6.3.10' }

              it 'does not return it ' do
                @expected = [all_vulns.last]
              end
            end
          end
        end

        context 'when introduced_in' do
          let(:db_data) { vuln_api_data_for('plugins/vulnerable-introduced-in') }

          let(:all_vulns) do
            [
              WPScan::Vulnerability.new(
                'Introduced In 6.4',
                fixed_in: '6.5',
                introduced_in: '6.4',
                references: { wpvulndb: '1' }
              )
            ]
          end

          context 'when no plugin version' do
            before { expect(plugin).to receive(:version).at_least(1).and_return(false) }

            it 'returns all the vulnerabilities' do
              @expected = all_vulns
            end
          end

          context 'when plugin version' do
            before do
              expect(plugin)
                .to receive(:version)
                .at_least(1)
                .and_return(WPScan::Model::Version.new(number))
            end

            context 'when < to introduced_in' do
              let(:number) { '5.0' }

              it 'does not return it' do
                @expected = []
              end
            end

            context 'when >= to fixed_in' do
              let(:number) { '6.5' }

              it 'does not return it' do
                @expected = []
              end
            end

            context 'when >= to introduced_in' do
              let(:number) { '6.4' }

              it 'returns it' do
                @expected = all_vulns
              end
            end
          end
        end
      end
    end
  end
end
