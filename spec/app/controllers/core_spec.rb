# frozen_string_literal: true

describe WPScan::Controller::Core do
  subject(:core)       { described_class.new }
  let(:target_url)     { 'http://ex.lo/' }
  let(:cli_args)       { "--url #{target_url}" }

  before do
    described_class.reset
    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
  end

  describe '#cli_options' do
    its(:cli_options) { should_not be_empty }
    its(:cli_options) { should be_a Array }

    it 'contains to correct options' do
      cli_options = core.cli_options
      expect(cli_options.map(&:to_sym)).to include(:url, :server, :force, :update)

      # Ensures the :url is the first one and is correctly setup
      expect(cli_options.first.to_sym).to eql :url
      expect(cli_options.first.required_unless).to match_array %i[update help hh version]
    end
  end

  describe '#load_server_module' do
    after do
      expect(core.target).to receive(:server).and_return(@stubbed_server)
      expect(core.load_server_module).to eql @expected

      [core.target, WPScan::Model::WpItem.new(target_url, core.target)].each do |instance|
        expect(instance).to respond_to(:directory_listing?)
        expect(instance).to respond_to(:directory_listing_entries)

        # The below doesn't work, the module would have to be removed from the class
        # TODO: find a way to test this
        # expect(instance.server).to eql @expected if instance.is_a? WPScan::Model::WpItem
      end
    end

    context 'when no --server supplied' do
      %i[Apache IIS Nginx].each do |server|
        it "loads the #{server} module and returns :#{server}" do
          @stubbed_server = server
          @expected       = server
        end
      end
    end

    context 'when --server' do
      %i[apache iis nginx].each do |server|
        context "when #{server}" do
          let(:cli_args) { "#{super()} --server #{server}" }
          let(:servers)  { [:Apache, nil, :IIS, :Nginx] }

          it "loads the #{server.capitalize} module and returns :#{server}" do
            @stubbed_server = servers.sample
            @expected       = server == :iis ? :IIS : server.to_s.camelize.to_sym
          end
        end
      end
    end
  end

  describe '#update_db_required?' do
    context 'when missing files' do
      before { expect(core.local_db).to receive(:missing_files?).ordered.and_return(true) }

      context 'when --no-update' do
        let(:cli_args) { "#{super()} --no-update" }

        it 'raises an error' do
          expect { core.update_db_required? }.to raise_error(WPScan::Error::MissingDatabaseFile)
        end
      end

      context 'otherwise' do
        its(:update_db_required?) { should eql true }
      end
    end

    context 'when not missing files' do
      before { expect(core.local_db).to receive(:missing_files?).ordered.and_return(false) }

      context 'when --update' do
        let(:cli_args) { "#{super()} --update" }

        its(:update_db_required?) { should eql true }
      end

      context 'when --no-update' do
        let(:cli_args) { "#{super()} --no-update" }

        its(:update_db_required?) { should eql false }
      end

      context 'when user_interation (i.e cli output)' do
        let(:cli_args) { "#{super()} --format cli" }

        context 'when the db is up-to-date' do
          before { expect(core.local_db).to receive(:outdated?).and_return(false) }

          its(:update_db_required?) { should eql false }
        end

        context 'when the db is outdated' do
          before do
            allow(core).to receive(:user_interaction?).and_return(true)
            expect(core.local_db).to receive(:outdated?).ordered.and_return(true)
            expect(core.formatter).to receive(:output).with('@notice', hash_including(:msg), 'core').ordered
            expect($stdout).to receive(:write).ordered # for the print()
          end

          context 'when a positive answer' do
            before do
              allow($stdin).to receive(:gets).and_return("Yes\n")
            end

            its(:update_db_required?) { should eql true }
          end

          context 'when a negative answer' do
            before do
              allow($stdin).to receive(:gets).and_return("No\n")
            end

            its(:update_db_required?) { should eql false }
          end
        end
      end

      context 'when no user_interation' do
        let(:cli_args) { "#{super()} --format json" }

        its(:update_db_required?) { should eql false }
      end
    end
  end

  describe '#before_scan' do
    before do
      stub_request(:get, target_url)

      expect(core.formatter).to receive(:output).with('banner', hash_including(verbose: nil), 'core')

      expect(core).to receive(:update_db_required?).and_return(false) unless WPScan::ParsedCli.update
    end

    context 'when --update' do
      before do
        expect(core.formatter).to receive(:output)
          .with('db_update_started', hash_including(verbose: nil), 'core').ordered

        expect_any_instance_of(WPScan::DB::Updater).to receive(:update)

        expect(core.formatter).to receive(:output)
          .with('db_update_finished', hash_including(verbose: nil), 'core').ordered
      end

      context 'when the --url is not supplied' do
        let(:cli_args) { '--update' }

        it 'calls the formatter when started and finished to update the db and exit' do
          expect { core.before_scan }.to raise_error(SystemExit)
        end
      end

      context 'when --url is supplied' do
        let(:cli_args) { "#{super()} --update" }

        before do
          expect(core).to receive(:load_server_module)
          expect(core.target).to receive(:wordpress?).with(:mixed).and_return(true)
          expect(core.target).to receive(:wordpress_hosted?).and_return(false)
        end

        it 'calls the formatter when started and finished to update the db' do
          expect { core.before_scan }.to_not raise_error
        end
      end
    end

    context 'when hosted on wordpress.com' do
      let(:target_url) { 'http://ex.wordpress.com' }

      before { expect(core).to receive(:load_server_module) }

      it 'raises an error' do
        expect { core.before_scan }.to raise_error(WPScan::Error::WordPressHosted)
      end
    end

    context 'when not hosted on wordpress.com' do
      before { allow(core.target).to receive(:wordpress_hosted?).and_return(false) }

      context 'when a redirect occurs' do
        before do
          stub_request(:any, target_url)

          expect(core.target).to receive(:homepage_res)
            .at_least(1)
            .and_return(Typhoeus::Response.new(effective_url: redirection, body: ''))
        end

        context 'to the wp-admin/install.php' do
          let(:redirection) { "#{target_url}wp-admin/install.php" }

          it 'calls the formatter with the correct parameters and exit' do
            expect(core.formatter).to receive(:output)
              .with('not_fully_configured', hash_including(url: redirection), 'core').ordered

            # TODO: Would be cool to be able to test the exit code
            expect { core.before_scan }.to raise_error(SystemExit)
          end
        end

        context 'to something else' do
          let(:redirection) { 'http://g.com/' }

          it 'raises an error' do
            expect { core.before_scan }.to raise_error(WPScan::Error::HTTPRedirect)
          end

          context 'when --follow-redirect' do
            let(:cli_args) { "#{super()} --follow-redirect" }

            it 'updates the target URL and does not raise an error' do
              expect(core).to receive(:load_server_module)
              expect(core.target).to receive(:wordpress?).with(:mixed).and_return(true)

              expect { core.before_scan }.to_not raise_error
              expect(core.target.url).to eq(redirection)
            end
          end
        end

        context 'to a different domain with different path' do
          let(:redirection) { 'http://g.com/blog/' }

          it 'raises an error without --follow-redirect' do
            expect { core.before_scan }.to raise_error(WPScan::Error::HTTPRedirect)
          end

          context 'when --follow-redirect' do
            let(:cli_args) { "#{super()} --follow-redirect" }

            it 'updates the target URL and adds domain to scope' do
              expect(core).to receive(:load_server_module)
              expect(core.target).to receive(:wordpress?).with(:mixed).and_return(true)

              expect { core.before_scan }.to_not raise_error
              expect(core.target.url).to eq(redirection)
              expect(core.target.in_scope?('http://g.com/other')).to be true
            end
          end

          context 'when both --follow-redirect and --ignore-main-redirect' do
            let(:cli_args) { "#{super()} --follow-redirect --ignore-main-redirect" }

            it 'follows the redirect (--follow-redirect takes precedence)' do
              expect(core).to receive(:load_server_module)
              expect(core.target).to receive(:wordpress?).with(:mixed).and_return(true)

              expect { core.before_scan }.to_not raise_error
              expect(core.target.url).to eq(redirection)
            end
          end
        end

        context 'to another path with the wp-admin/install.php in the query' do
          let(:redirection) { "#{target_url}index.php?a=/wp-admin/install.php" }

          context 'when wordpress' do
            it 'does not raise an error' do
              expect(core.target).to receive(:wordpress?).with(:mixed).and_return(true)

              expect { core.before_scan }.to_not raise_error
            end
          end

          context 'when not wordpress' do
            it 'raises an error' do
              expect(core.target).to receive(:wordpress?).twice.with(:mixed).and_return(false)

              expect { core.before_scan }.to raise_error(WPScan::Error::NotWordPress)
            end
          end
        end
      end

      context 'when wordpress' do
        before do
          expect(core).to receive(:load_server_module)
          expect(core.target).to receive(:wordpress?).with(:mixed).and_return(true)
        end

        it 'does not raise any error' do
          expect { core.before_scan }.to_not raise_error
        end
      end

      context 'when not wordpress' do
        before do
          expect(core).to receive(:load_server_module)
        end

        context 'when no --force' do
          before { expect(core.target).to receive(:maybe_add_cookies) }

          context 'when no cookies added or still not wordpress after being added' do
            it 'raises an error' do
              expect(core.target).to receive(:wordpress?).twice.with(:mixed).and_return(false)

              expect { core.before_scan }.to raise_error(WPScan::Error::NotWordPress)
            end
          end

          context 'when the added cookies solved it' do
            it 'does not raise an error' do
              expect(core.target).to receive(:wordpress?).with(:mixed).and_return(false).ordered
              expect(core.target).to receive(:wordpress?).with(:mixed).and_return(true).ordered

              expect { core.before_scan }.to_not raise_error
            end
          end
        end

        context 'when --force' do
          let(:cli_args) { "#{super()} --force" }

          it 'does not raise any error' do
            expect(core.target).to receive(:wordpress?).with(:mixed).and_return(false)

            expect { core.before_scan }.to_not raise_error
          end
        end
      end
    end
  end

  describe '#run' do
    before do
      allow(WPScan).to receive(:command_line).and_return('--url http://ex.wordpress.com/')
      allow(Socket).to receive(:gethostname).and_return('test-hostname')

      # Mock the target to avoid HTTP requests
      target = double('Target')
      allow(target).to receive(:url).and_return(target_url)
      allow(target).to receive(:ip).and_return('127.0.0.1')
      allow(target).to receive(:homepage_url).and_return(target_url)
      allow(core).to receive(:target).and_return(target)
    end

    it 'passes command_line and hostname to the output' do
      expect(core.formatter).to receive(:output).with(
        'started',
        hash_including(
          command_line: '--url http://ex.wordpress.com/',
          hostname: 'test-hostname'
        ),
        'core'
      )

      core.run
    end
  end

  describe '#after_scan' do
    before do
      # Set up some test data
      WPScan.reset_status_codes
      WPScan.total_requests = 100
      WPScan.cached_requests = 10
      WPScan.total_data_sent = 1024
      WPScan.total_data_received = 2048

      core.instance_variable_set(:@start_time, Time.now - 60)
      core.instance_variable_set(:@start_memory, 0)
    end

    context 'when status codes are tracked' do
      before do
        WPScan.set_status_code(200, 80)
        WPScan.set_status_code(404, 15)
        WPScan.set_status_code(500, 5)
      end

      it 'includes status codes in the output' do
        expect(core.formatter).to receive(:output).with(
          'finished',
          hash_including(
            response_status_codes: { '200' => 80, '404' => 15, '500' => 5 },
            response_status_codes_warning: false,
            response_status_codes_warnings: []
          ),
          'core'
        )

        core.after_scan
      end
    end

    context 'when concerning error codes are detected' do
      before do
        WPScan.set_status_code(200, 50)
        WPScan.set_status_code(429, 30)
        WPScan.set_status_code(500, 20)
      end

      it 'sets response_status_codes_warning to true' do
        expect(core.formatter).to receive(:output).with(
          'finished',
          hash_including(
            response_status_codes: { '200' => 50, '429' => 30, '500' => 20 },
            response_status_codes_warning: true,
            response_status_codes_warnings: include(
              /Rate limiting detected/,
              /Too many server errors/
            )
          ),
          'core'
        )

        core.after_scan
      end
    end

    context 'when no concerning errors (404s are excluded)' do
      before do
        WPScan.set_status_code(200, 50)
        WPScan.set_status_code(404, 50) # 404s should not trigger warnings
      end

      it 'sets response_status_codes_warning to false' do
        expect(core.formatter).to receive(:output).with(
          'finished',
          hash_including(
            response_status_codes: { '200' => 50, '404' => 50 },
            response_status_codes_warning: false,
            response_status_codes_warnings: []
          ),
          'core'
        )

        core.after_scan
      end
    end

    context 'when many failed requests (code 0)' do
      before do
        WPScan.set_status_code(200, 80)
        WPScan.set_status_code(0, 20) # 20 failed requests
      end

      it 'sets response_status_codes_warning to true with appropriate message' do
        expect(core.formatter).to receive(:output).with(
          'finished',
          hash_including(
            response_status_codes: { '200' => 80, 'failed' => 20 },
            response_status_codes_warning: true,
            response_status_codes_warnings: ['Too many failed requests (no response) could indicate ' \
                                             'network issues, WAF/IPS blocking, or an unavailable target']
          ),
          'core'
        )

        core.after_scan
      end
    end

    context 'when multiple error conditions exist' do
      before do
        WPScan.set_status_code(200, 50)
        WPScan.set_status_code(429, 15)  # Rate limiting
        WPScan.set_status_code(500, 20)  # Server errors
        WPScan.set_status_code(0, 15)    # Failed requests
      end

      it 'returns all applicable warning messages' do
        expect(core.formatter).to receive(:output).with(
          'finished',
          hash_including(
            response_status_codes: { '200' => 50, '429' => 15, '500' => 20, 'failed' => 15 },
            response_status_codes_warning: true,
            response_status_codes_warnings: include(
              /Too many failed requests/,
              /Rate limiting detected/,
              /Too many server errors/
            )
          ),
          'core'
        )

        core.after_scan
      end
    end
  end
end
