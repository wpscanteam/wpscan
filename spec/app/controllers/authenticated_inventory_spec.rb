# frozen_string_literal: true

describe WPScan::Controller::AuthenticatedInventory do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://wp.lab/' }
  let(:plugins_url)    { 'http://wp.lab/wp-json/wp/v2/plugins' }
  let(:themes_url)     { 'http://wp.lab/wp-json/wp/v2/themes' }
  let(:plugins_fixture) { FINDERS_FIXTURES.join('plugins', 'wp_json_api', 'plugins.json') }
  let(:themes_fixture)  { FINDERS_FIXTURES.join('themes',  'wp_json_api', 'themes.json') }

  before do
    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
    described_class.reset
  end

  describe '#run' do
    context 'when --wp-auth is not provided' do
      let(:cli_args) { "--url #{target_url}" }

      it 'is a no-op (does not touch the target)' do
        expect_any_instance_of(WPScan::Target).not_to receive(:instance_variable_set)
        controller.run
      end
    end

    context 'when --wp-auth is provided' do
      let(:cli_args) { "--url #{target_url} --wp-auth admin:secret" }

      before do
        allow(controller.target).to receive(:sub_dir).and_return(false)
        allow(controller.target).to receive(:content_dir).and_return('wp-content')
        allow(controller.target).to receive(:plugins_dir).and_return('wp-content/plugins')
        allow(controller.target).to receive(:themes_dir).and_return('wp-content/themes')

        # Theme#initialize fetches style.css
        stub_request(:get, %r{http://wp\.lab/wp-content/themes/.*/style\.css}).to_return(body: '')

        stub_request(:get, plugins_url).to_return(status: 200, body: File.read(plugins_fixture))
        stub_request(:get, themes_url).to_return(status: 200, body: File.read(themes_fixture))

        allow(controller.formatter).to receive(:output)
      end

      it 'pre-populates the target with plugins, themes, and the active main theme' do
        controller.run

        plugins = controller.target.instance_variable_get(:@plugins)
        themes  = controller.target.instance_variable_get(:@themes)
        main    = controller.target.instance_variable_get(:@main_theme)

        expect(plugins.map(&:slug)).to eql %w[akismet wordfence hello no-version-plugin]
        expect(themes.map(&:slug)).to eql %w[twentytwentyfour twentytwentythree]
        expect(main.slug).to eql 'twentytwentyfour'
      end

      it 'outputs plugins and themes via the enumeration templates so JSON/CLI match a -e scan' do
        expect(controller.formatter).to receive(:output)
          .with('plugins', hash_including(plugins: kind_of(Array)), 'enumeration')
        expect(controller.formatter).to receive(:output)
          .with('themes', hash_including(themes: kind_of(Array)), 'enumeration')
        controller.run
      end
    end
  end
end
