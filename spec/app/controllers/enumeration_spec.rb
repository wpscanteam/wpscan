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

        context 'when vulnerable and mixed detection' do
          let(:cli_args) { "#{super()} -e v#{type[0]}" }

          it 'returns the expected string' do
            @expected = "Enumerating Vulnerable #{type.capitalize} (via Passive and Aggressive Methods)"
          end
        end

        context 'when all and passive detection' do
          let(:cli_args)       { "#{super()} -e a#{type[0]}" }
          let(:detection_mode) { :passive }

          it 'returns the expected string' do
            @expected = "Enumerating All #{type.capitalize} (via Passive Methods)"
          end
        end

        context 'when most popular and aggressive detection' do
          let(:cli_args)       { "#{super()} -e #{type[0]}" }
          let(:detection_mode) { :aggressive }

          it 'returns the expected string' do
            @expected = "Enumerating Most Popular #{type.capitalize} (via Aggressive Methods)"
          end
        end
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
           medias_detection
           users_list users_detection exclude_usernames]
      )
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
          %i[plugins themes timthumbs config_backups db_exports users medias].each do |option|
            expect(controller).to receive("enum_#{option}".to_sym)
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
            expect(controller).to receive("enum_#{option}".to_sym)
          end
        end
      end
    end
  end
end
