# frozen_string_literal: true

describe WPScan::Finders::PluginVersion::Readme do
  subject(:finder) { described_class.new(plugin) }
  let(:plugin)     { WPScan::Model::Plugin.new('spec', target) }
  let(:target)     { WPScan::Target.new('http://wp.lab/') }
  let(:fixtures)   { FINDERS_FIXTURES.join('plugin_version', 'readme') }

  def version(number, found_by, confidence)
    WPScan::Model::Version.new(
      number,
      found_by: format('Readme - %s (Aggressive Detection)', found_by),
      confidence: confidence,
      interesting_entries: [readme_url]
    )
  end

  def stable_tag(number)
    version(number, 'Stable Tag', 80)
  end

  def changelog_section(number)
    version(number, 'ChangeLog Section', 50)
  end

  describe '#aggressive' do
    before do
      expect(target).to receive(:content_dir).and_return('wp-content')

      allow(target).to receive(:head_or_get_params).and_return(method: :head)

      stub_request(:head, /.*/).to_return(status: 404)
      stub_request(:head, readme_url).to_return(status: 200)
    end

    let(:readme_url) { plugin.url(WPScan::Model::WpItem::READMES.sample) }

    after do
      stub_request(:get, readme_url).to_return(body: File.read(fixtures.join(@file)))

      expect(finder.aggressive).to eql @expected
    end

    context 'when no version' do
      it 'returns nil' do
        @file     = 'no_version.txt'
        @expected = nil
      end
    end

    context 'when the stable tag does not contain numbers' do
      it 'returns nil' do
        @file     = 'aa-health-calculator.txt'
        @expected = nil
      end
    end

    context 'when empty changelog section' do
      it 'returns nil' do
        @file     = 'all-in-one-facebook.txt'
        @expected = nil
      end
    end

    context 'when no changelog section' do
      it 'returns nil' do
        @file     = 'blog-reordering.txt'
        @expected = nil
      end
    end

    context 'when leaked from the stable tag' do
      it 'returns the expected versions' do
        @file     = 'simple-login-lockdown-0.4.txt'
        @expected = [stable_tag('0.4'), changelog_section('04')]
      end
    end

    context 'when leaked from the version' do
      it 'returns it' do
        @file     = 'wp-photo-plus-5.1.15.txt'
        @expected = [stable_tag('5.1.15')]
      end
    end

    context 'when version is in a release date format' do
      it 'detects and returns it' do
        @file     = 's2member.txt'
        @expected = [stable_tag('141007')]
      end
    end

    context 'when version contains letters' do
      it 'returns it' do
        @file     = 'beta1.txt'
        @expected = [stable_tag('2.0.0-beta1')]
      end
    end

    context 'when parsing the changelog for version numbers' do
      {
        'changelog_version' => '1.3',
        'wp_polls' => '2.64',
        'nextgen_gallery' => '2.0.66.33',
        'wp_user_frontend' => '1.2.3',
        'my_calendar' => '2.1.5',
        'nextgen_gallery_2' => '1.9.13',
        'advanced-most-recent-posts-mod' => '1.6.5.2',
        'a-lead-capture-contact-form-and-tab-button-by-awebvoicecom' => '3.1',
        'backup-scheduler' => '1.5.9',
        'release_date_slash' => '1.0.4'
      }.each do |file, version_number|
        context "whith #{file}.txt" do
          it 'returns the expected version' do
            @file = "#{file}.txt"
            @expected = [changelog_section(version_number)]
          end
        end
      end
    end
  end
end
