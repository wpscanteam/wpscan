# frozen_string_literal: true

describe WPScan::Controller::Enumeration do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://wp.lab/' }
  let(:cli_args)       { "--url #{target_url}" }

  before do
    ## For the --passwords options
    allow_any_instance_of(OptParseValidator::OptPath).to receive(:check_file)

    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
  end

  describe '#enum_message' do
    after { expect(controller.enum_message(type, detection_mode)).to eql @expected }

    context 'when type argument is incorrect' do
      let(:type)           { 'spec' }
      let(:detection_mode) { :mixed }

      it 'returns nil' do
        @expected = nil
      end
    end

    %w[plugins themes].each do |t|
      context "type = #{t}" do
        let(:type)           { t }
        let(:detection_mode) { :mixed }

        context 'when vulnerable' do
          let(:cli_args) { "#{super()} -e v#{type[0]}" }

          it 'returns the expected string' do
            @expected = "Enumerating Vulnerable #{type.capitalize} (via Passive and Aggressive Methods)"
          end
        end

        context 'when all' do
          let(:cli_args)       { "#{super()} -e a#{type[0]}" }
          let(:detection_mode) { :passive }

          it 'returns the expected string' do
            @expected = "Enumerating All #{type.capitalize} (via Passive Methods)"
          end
        end

        context 'when most popular' do
          let(:cli_args)       { "#{super()} -e #{type[0]}" }
          let(:detection_mode) { :aggressive }

          it 'returns the expected string' do
            @expected = "Enumerating Most Popular #{type.capitalize} (via Aggressive Methods)"
          end
        end
      end
    end
  end

  describe '#default_opts' do
    context 'when no --enumerate' do
      it 'contains the correct version_detection' do
        expect(controller.default_opts('plugins')[:version_detection]).to include(mode: :mixed)
      end
    end
  end

  describe '#cli_options' do
    it 'contains the correct options' do
      expect(controller.cli_options.map(&:to_sym)).to eql(
        %i[enumerate exclude_content_based
           plugins_list plugins_detection plugins_version_all plugins_version_detection plugins_threshold
           themes_list themes_detection themes_version_all themes_version_detection themes_threshold
           timthumbs_list timthumbs_detection
           config_backups_list config_backups_detection
           db_exports_list db_exports_detection
           backup_folders_list
           medias_detection
           users_list users_detection exclude_usernames]
      )
    end
  end

  describe '#before_scan' do
    context 'when enumerating vulnerable plugins without API token' do
      let(:cli_args) { "#{super()} -e vp" }

      it 'raises ApiTokenRequiredForVulnerableEnumeration error' do
        expect { controller.before_scan }.to raise_error(WPScan::Error::ApiTokenRequiredForVulnerableEnumeration)
      end
    end

    context 'when enumerating vulnerable themes without API token' do
      let(:cli_args) { "#{super()} -e vt" }

      it 'raises ApiTokenRequiredForVulnerableEnumeration error' do
        expect { controller.before_scan }.to raise_error(WPScan::Error::ApiTokenRequiredForVulnerableEnumeration)
      end
    end

    context 'when enumerating vulnerable plugins with API token' do
      let(:cli_args) { "#{super()} -e vp --api-token test-token" }

      before do
        # Simulate the VulnApi controller running before Enumeration
        vuln_api_controller = WPScan::Controller::VulnApi.new
        allow(WPScan::DB::VulnApi).to receive(:status).and_return({ 'plan' => 'free', 'requests_remaining' => 25 })
        vuln_api_controller.before_scan
      end

      after { WPScan::DB::VulnApi.token = nil }

      it 'does not raise an error' do
        expect { controller.before_scan }.not_to raise_error
      end
    end

    context 'when enumerating non-vulnerable plugins without API token' do
      let(:cli_args) { "#{super()} -e p" }

      it 'does not raise an error' do
        expect { controller.before_scan }.not_to raise_error
      end
    end
  end

  describe '#enum_users' do
    before { expect(controller.formatter).to receive(:output).twice }
    after { controller.enum_users }

    context 'when --enumerate has been supplied' do
      let(:cli_args) { "#{super()} -e u1-10" }

      it 'calls the target.users with the correct range' do
        expect(controller.target).to receive(:users).with(hash_including(range: (1..10)))
      end
    end

    context 'when --passwords supplied but no --username or --usernames' do
      let(:cli_args) { "#{super()} --passwords some-file.txt" }

      it 'calls the target.users with the default range' do
        expect(controller.target).to receive(:users).with(hash_including(range: (1..10)))
      end
    end
  end

  describe '#run' do
    context 'when no :enumerate' do
      it 'does not call any enum methods' do
        expect(controller).not_to receive(:enum_plugins)
        expect(controller).not_to receive(:enum_themes)
        expect(controller).not_to receive(:enum_config_backups)
        expect(controller).not_to receive(:enum_timthumbs)
        expect(controller).not_to receive(:enum_db_exports)
        expect(controller).not_to receive(:enum_users)
        expect(controller).not_to receive(:enum_medias)

        controller.run
      end

      context 'when --passwords supplied but no --username or --usernames' do
        let(:cli_args) { "#{super()} --passwords some-file.txt" }

        it 'calls the enum_users' do
          expect(controller).to receive(:enum_users)
          controller.run
        end
      end
    end

    context 'when :enumerate' do
      after { controller.run }

      context 'when no option supplied' do
        let(:cli_args) { "#{super()} -e" }

        it 'calls the correct enum methods' do
          %i[plugins themes timthumbs config_backups db_exports backup_folders users medias].each do |option|
            expect(controller).to receive(:"enum_#{option}")
          end
        end
      end

      %i[p ap vp].each do |option|
        context "when #{option}" do
          let(:cli_args) { "#{super()} -e #{option}" }

          it 'calls the #enum_plugins' do
            expect(controller).to receive(:enum_plugins)
          end
        end
      end

      %i[t at vt].each do |option|
        context option.to_s do
          let(:cli_args) { "#{super()} -e #{option}" }

          it 'calls the #enum_themes' do
            expect(controller).to receive(:enum_themes)
          end
        end
      end

      { timthumbs: 'tt', config_backups: 'cb', db_exports: 'dbe', medias: 'm', users: 'u' }.each do |option, shortname|
        context "when #{option}" do
          let(:cli_args) { "#{super()} -e #{shortname}" }

          it "calls the ##{option}" do
            expect(controller).to receive(:"enum_#{option}")
          end
        end
      end
    end

    context 'when --plugins-list is supplied without --enumerate' do
      let(:cli_args) { "#{super()} --plugins-list a,b,c" }

      it 'calls #enum_plugins' do
        expect(controller).to receive(:enum_plugins)
        expect(controller.formatter).not_to receive(:output).with('@notice', anything, anything)
        controller.run
      end
    end

    context 'when --themes-list is supplied without --enumerate' do
      let(:cli_args) { "#{super()} --themes-list a,b,c" }

      it 'calls #enum_themes' do
        expect(controller).to receive(:enum_themes)
        expect(controller.formatter).not_to receive(:output).with('@notice', anything, anything)
        controller.run
      end
    end

    %w[vp ap p].each do |choice|
      context "when --plugins-list collides with --enumerate #{choice}" do
        let(:cli_args) { "#{super()} -e #{choice} --plugins-list a,b,c" }

        it 'emits a notice and still calls #enum_plugins' do
          expect(controller.formatter).to receive(:output)
            .with('@notice', hash_including(:msg), 'enumeration')
          expect(controller).to receive(:enum_plugins)
          controller.run
        end
      end
    end

    %w[vt at t].each do |choice|
      context "when --themes-list collides with --enumerate #{choice}" do
        let(:cli_args) { "#{super()} -e #{choice} --themes-list a,b,c" }

        it 'emits a notice and still calls #enum_themes' do
          expect(controller.formatter).to receive(:output)
            .with('@notice', hash_including(:msg), 'enumeration')
          expect(controller).to receive(:enum_themes)
          controller.run
        end
      end
    end
  end
end
