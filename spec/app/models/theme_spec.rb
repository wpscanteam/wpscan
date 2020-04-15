# frozen_string_literal: true

describe WPScan::Model::Theme do
  subject(:theme)  { described_class.new(slug, blog, opts) }
  let(:slug)       { 'spec' }
  let(:blog)       { WPScan::Target.new('http://wp.lab/') }
  let(:opts)       { {} }
  let(:fixtures)   { FIXTURES.join('models', 'theme') }

  before { expect(blog).to receive(:content_dir).at_least(1).and_return('wp-content') }

  describe '#new' do
    before { stub_request(:get, /.*\.css\z/).to_return(body: File.read(fixture)) }

    let(:fixture) { fixtures.join('style.css') }

    its(:url) { should eql 'http://wp.lab/wp-content/themes/spec/' }
    its(:style_url) { should eql 'http://wp.lab/wp-content/themes/spec/style.css' }

    its(:style_name)  { should eql 'Twenty Fifteen' }
    its(:style_uri)   { should eql 'https://wordpress.org/themes/twentyfifteen' }
    its(:author)      { should eql 'the WordPress team' }
    its(:author_uri)  { should eql nil }
    its(:template)    { should eql nil }
    its(:description) { should eql 'Our 2015 default theme is clean, blog-focused.' }
    its(:license)     { should eql 'GNU General Public License v2 or later' }
    its(:license_uri) { should eql 'http://www.gnu.org/licenses/gpl-2.0.html' }
    its(:tags)        { should eql 'black, blue, gray, pink, purple, white, yellow.' }
    its(:text_domain) { should eql 'twentyfifteen' }

    context 'when opts[:style_url]' do
      let(:opts) { super().merge(style_url: 'http://wp.lab/wp-content/themes/spec/custom.css') }

      its(:style_url) { should eql opts[:style_url] }
    end

    context 'when some new lines are stripped' do
      let(:fixture) { fixtures.join('stripped_new_lines.css') }

      its(:style_name)  { should eql 'Divi' }
      its(:style_uri)   { should eql 'http://www.elegantthemes.com/gallery/divi/' }
      its(:license_uri) { should eql 'http://www.gnu.org/licenses/gpl-2.0.html' }
    end
  end

  describe '#version' do
    after do
      stub_request(:get, /.*\.css\z/)
        .to_return(body: File.read(fixtures.join('style.css')))

      expect(WPScan::Finders::ThemeVersion::Base).to receive(:find).with(theme, @expected_opts)
      theme.version(version_opts)
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

  describe '#latest_version, #last_updated, #popular' do
    before do
      stub_request(:get, /.*\.css\z/)
      allow(theme).to receive(:db_data).and_return(db_data)
    end

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
      let(:db_data) { vuln_api_data_for('themes/no-vulns-popular') }

      its(:latest_version) { should eql WPScan::Model::Version.new('2.2') }
      its(:last_updated) { should eql '2015-05-16T00:00:00.000Z-via-api' }
      its(:popular?) { should be true }
    end
  end

  describe '#outdated?' do
    before do
      stub_request(:get, /.*\.css\z/)
      allow(theme).to receive(:db_data).and_return({})
    end

    context 'when last_version' do
      let(:slug) { 'no-vulns-popular' }

      context 'when no version' do
        before { expect(theme).to receive(:version).at_least(1).and_return(nil) }

        its(:outdated?) { should eql false }
      end

      context 'when version' do
        before do
          expect(theme)
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
        before { expect(theme).to receive(:version).at_least(1).and_return(nil) }

        its(:outdated?) { should eql false }
      end

      context 'when version' do
        before do
          expect(theme)
            .to receive(:version)
            .at_least(1)
            .and_return(WPScan::Model::Version.new('1.0'))
        end

        its(:outdated?) { should eql false }
      end
    end
  end

  describe '#vulnerabilities' do
    before do
      stub_request(:get, /.*\.css\z/)
      allow(theme).to receive(:db_data).and_return(db_data)
    end

    after do
      expect(theme.vulnerabilities).to eq @expected
      expect(theme.vulnerable?).to eql @expected.empty? ? false : true
    end

    context 'when theme not in the DB' do
      let(:slug)    { 'not-in-db' }
      let(:db_data) { {} }

      it 'returns an empty array' do
        @expected = []
      end
    end

    context 'when in the DB' do
      context 'when no vulnerabilities' do
        let(:slug)    { 'no-vulns-popular' }
        let(:db_data) { vuln_api_data_for('themes/no-vulns-popular') }

        it 'returns an empty array' do
          @expected = []
        end
      end

      context 'when vulnerabilities' do
        let(:slug)    { 'vulnerable-not-popular' }
        let(:db_data) { vuln_api_data_for('themes/vulnerable-not-popular') }

        let(:all_vulns) do
          [
            WPScan::Vulnerability.new(
              'First Vuln',
              references: { wpvulndb: '1' },
              type: 'LFI',
              fixed_in: '6.3.10'
            ),
            WPScan::Vulnerability.new('No Fixed In', references: { wpvulndb: '2' })
          ]
        end

        context 'when no theme version' do
          before { expect(theme).to receive(:version).at_least(1).and_return(false) }

          it 'returns all the vulnerabilities' do
            @expected = all_vulns
          end
        end

        context 'when theme version' do
          before do
            expect(theme)
              .to receive(:version)
              .at_least(1)
              .and_return(WPScan::Model::Version.new(number))
          end

          context 'when < to a fixed_in' do
            let(:number) { '5.0' }

            it 'returns it' do
              @expected = all_vulns
            end
          end

          context 'when >= to a fixed_in' do
            let(:number) { '6.3.10' }

            it 'does not return it ' do
              @expected = [all_vulns.last]
            end
          end
        end
      end
    end
  end

  describe '#parent_theme' do
    before do
      stub_request(:get, blog.url('wp-content/themes/spec/style.css'))
        .to_return(body: File.read(fixtures.join(main_theme)))
    end

    context 'when no template' do
      let(:main_theme) { 'style.css' }

      it 'returns nil' do
        expect(theme.parent_theme).to eql nil
      end
    end

    context 'when a template' do
      let(:main_theme) { 'child_style.css' }
      let(:parent_url) { blog.url('wp-content/themes/twentyfourteen/custom.css') }

      before do
        stub_request(:get, parent_url)
          .to_return(body: File.read(fixtures.join('style.css')))
      end

      %w[child_style windows_line_endings].each do |fixture|
        context "when #{fixture}" do
          let(:main_theme) { "#{fixture}.css" }

          it 'returns the expected theme' do
            parent = theme.parent_theme

            expect(parent).to eql described_class.new(
              'twentyfourteen', blog,
              style_url: parent_url,
              confidence: 100,
              found_by: 'Parent Themes (Passive Detection)'
            )
            expect(parent.style_url).to eql parent_url
          end
        end
      end
    end
  end

  describe '#parent_themes' do
    xit
  end

  describe '#==' do
    before { stub_request(:get, /.*\.css\z/) }

    context 'when default style' do
      it 'returns true when equal' do
        expect(theme == described_class.new(slug, blog, opts)).to be true
      end

      it 'returns false when not equal' do
        expect(theme == described_class.new(slug, blog, opts.merge(style_url: 'spec.css'))).to be false
      end
    end

    context 'when custom style' do
      let(:opts) { super().merge(style_url: 'spec.css') }

      it 'returns true when equal' do
        expect(theme == described_class.new(slug, blog, opts.merge(style_url: 'spec.css'))).to be true
      end

      it 'returns false when not equal' do
        expect(theme == described_class.new(slug, blog, opts.merge(style_url: 'spec2.css'))).to be false
      end
    end
  end
end
