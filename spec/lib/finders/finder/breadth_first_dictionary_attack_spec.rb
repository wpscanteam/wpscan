# frozen_string_literal: true

describe WPScan::Finders::Finder::BreadthFirstDictionaryAttack do
  # Dummy class to test the module
  class DummyBreadthFirstDictionaryAttack < WPScan::Finders::Finder
    include WPScan::Finders::Finder::BreadthFirstDictionaryAttack

    def login_request(username, password)
      Typhoeus::Request.new('http://e.org/login.php',
                            method: :post,
                            body: { username: username, pwd: password })
    end

    def valid_credentials?(response)
      response.code == 302
    end

    def errored_response?(response)
      response.timed_out? || response.code.zero? ||
        response.code.to_s.start_with?('5') || response.body.include?('Error:')
    end
  end

  subject(:finder) { DummyBreadthFirstDictionaryAttack.new(target) }
  let(:target)     { WPScan::Target.new('http://e.org') }
  let(:login_url)  { target.url('login.php') }

  before { stub_request(:get, /e\.org/) }

  describe '#attack' do
    let(:users) { %w[admin root user].map { |u| WPScan::Model::User.new(u) } }
    let(:wordlist_path) { FIXTURES.join('passwords.txt').to_s }

    before do
      File.foreach(wordlist_path) do |password|
        users.each do |user|
          stub_request(:post, login_url)
            .with(body: { username: user.username, pwd: password.chomp })
            .to_return(status: 401)
        end
      end
    end

    context 'when no valid credentials' do
      it 'does not yield anything' do
        expect { |block| finder.attack(users, wordlist_path, &block) }.not_to yield_control
      end

      context 'when trying to increment above current progress' do
        it 'does not call #increment' do
          expect_any_instance_of(ProgressBar::Base)
            .to receive(:progress)
            .at_least(1)
            .and_return(users.size * File.foreach(wordlist_path).count)

          expect_any_instance_of(ProgressBar::Base)
            .not_to receive(:increment)

          expect { |block| finder.attack(users, wordlist_path, &block) }.not_to yield_control
        end
      end
    end

    context 'when valid credentials' do
      before do
        stub_request(:post, login_url)
          .with(body: { username: 'admin', pwd: 'admin' })
          .to_return(status: 302)
      end

      it 'yields the matching user' do
        expect { |block| finder.attack(users, wordlist_path, &block) }
          .to yield_with_args(WPScan::Model::User.new('admin', password: 'admin'))
      end

      context 'when the progressbar total= failed' do
        it 'does not raise an error' do
          expect_any_instance_of(ProgressBar::Base).to receive(:total=).and_raise ProgressBar::InvalidProgressError

          expect { |block| finder.attack(users, wordlist_path, &block) }
            .to yield_with_args(WPScan::Model::User.new('admin', password: 'admin'))
        end
      end
    end

    context 'when wordlist_skip is provided' do
      context 'when skipping first password' do
        before do
          stub_request(:post, login_url)
            .with(body: { username: 'admin', pwd: 'admin' })
            .to_return(status: 302)
        end

        it 'skips the specified number of passwords and finds the valid one' do
          expect { |block| finder.attack(users, wordlist_path, wordlist_skip: 1, &block) }
            .to yield_with_args(WPScan::Model::User.new('admin', password: 'admin'))

          # Verify that 'pwd' (first password) was not tried for any user
          expect(a_request(:post, login_url).with(body: { username: 'admin', pwd: 'pwd' }))
            .not_to have_been_made
          expect(a_request(:post, login_url).with(body: { username: 'root', pwd: 'pwd' }))
            .not_to have_been_made
          expect(a_request(:post, login_url).with(body: { username: 'user', pwd: 'pwd' }))
            .not_to have_been_made
        end
      end

      context 'when skipping all passwords' do
        it 'does not yield anything and makes no requests' do
          expect { |block| finder.attack(users, wordlist_path, wordlist_skip: 3, &block) }
            .not_to yield_control

          # Verify no password attempts were made
          expect(a_request(:post, login_url)).not_to have_been_made
        end
      end

      context 'when skip count is larger than wordlist' do
        it 'does not yield anything and makes no requests' do
          expect { |block| finder.attack(users, wordlist_path, wordlist_skip: 100, &block) }
            .not_to yield_control

          expect(a_request(:post, login_url)).not_to have_been_made
        end
      end
    end

    context 'when an error is present in a response' do
      before do
        if defined?(stub_params)
          stub_request(:post, login_url)
            .with(body: { username: 'admin', pwd: 'pwd' })
            .to_return(stub_params)
        else
          stub_request(:post, login_url)
            .with(body: { username: 'admin', pwd: 'pwd' })
            .to_timeout
        end

        WPScan::ParsedCli.options = { verbose: defined?(verbose) ? verbose : false }

        finder.attack(users, wordlist_path)
      end

      context 'when request timeout' do
        it 'logs to correct message' do
          expect(finder.progress_bar.log).to eql [
            'Error: Request timed out.'
          ]
        end
      end

      context 'when status/code = 0' do
        let(:stub_params) { { status: 0, body: 'Error: Down' } }

        it 'logs to correct message' do
          expect(finder.progress_bar.log).to eql [
            'Error: No response from remote server. WAF/IPS? ()'
          ]
        end
      end

      context 'when error 500' do
        let(:stub_params) { { status: 500, body: 'Error: 500' } }

        it 'logs to correct message' do
          expect(finder.progress_bar.log).to eql [
            'Error: Server error, try reducing the number of threads.'
          ]
        end
      end

      context 'when unknown error' do
        let(:stub_params) { { status: 200, body: 'Error: Something went wrong' } }

        context 'when no --verbose' do
          let(:verbose) { false }

          it 'logs to correct message' do
            expect(finder.progress_bar.log).to eql [
              'Error: Unknown response received Code: 200'
            ]
          end
        end

        context 'when --verbose' do
          let(:verbose) { true }

          it 'logs to correct message' do
            expect(finder.progress_bar.log).to eql [
              "Error: Unknown response received Code: 200\nBody: Error: Something went wrong"
            ]
          end
        end
      end
    end

    context 'when max_retries is provided' do
      let(:users) { [WPScan::Model::User.new('admin')] }

      context 'when request succeeds after retry' do
        before do
          # First attempt times out, second succeeds
          stub_request(:post, login_url)
            .with(body: { username: 'admin', pwd: 'pwd' })
            .to_timeout
            .then
            .to_return(status: 302, headers: { 'Set-Cookie' => 'wordpress_logged_in_hash=valid' })
        end

        it 'retries and finds valid credentials' do
          expect { |block| finder.attack(users, wordlist_path, max_retries: 2, show_progression: true, &block) }
            .to yield_with_args(WPScan::Model::User.new('admin', password: 'pwd'))
        end
      end

      context 'when max retries exhausted' do
        before do
          # All attempts timeout
          stub_request(:post, login_url)
            .with(body: { username: 'admin', pwd: 'pwd' })
            .to_timeout
        end

        it 'exhausts retries and logs final error' do
          finder.attack(users, wordlist_path, max_retries: 2)

          # Final error should be logged
          expect(finder.progress_bar.log).to eql(['Error: Request timed out.'])
        end

        it 'does not yield' do
          expect { |block| finder.attack(users, wordlist_path, max_retries: 2, &block) }
            .not_to yield_control
        end
      end

      context 'when max_retries is 0 (default)' do
        before do
          stub_request(:post, login_url)
            .with(body: { username: 'admin', pwd: 'pwd' })
            .to_timeout
        end

        it 'does not retry' do
          finder.attack(users, wordlist_path, max_retries: 0)

          # Should only have error message, no retry messages
          expect(finder.progress_bar.log).to eql(['Error: Request timed out.'])
        end
      end

      context 'when different error types' do
        let(:users) { [WPScan::Model::User.new('admin')] }

        context 'connection error with retry' do
          before do
            # First attempt fails with connection error, second succeeds
            stub_request(:post, login_url)
              .with(body: { username: 'admin', pwd: 'pwd' })
              .to_return(status: 0, body: '')
              .then
              .to_return(status: 302, headers: { 'Set-Cookie' => 'wordpress_logged_in_hash=valid' })
          end

          it 'retries and succeeds' do
            expect { |block| finder.attack(users, wordlist_path, max_retries: 1, &block) }
              .to yield_with_args(WPScan::Model::User.new('admin', password: 'pwd'))
          end
        end

        context 'server error with retry' do
          before do
            # First attempt gets 500 error, second succeeds
            stub_request(:post, login_url)
              .with(body: { username: 'admin', pwd: 'pwd' })
              .to_return(status: 500, body: 'Internal Server Error')
              .then
              .to_return(status: 302, headers: { 'Set-Cookie' => 'wordpress_logged_in_hash=valid' })
          end

          it 'retries and succeeds' do
            expect { |block| finder.attack(users, wordlist_path, max_retries: 1, &block) }
              .to yield_with_args(WPScan::Model::User.new('admin', password: 'pwd'))
          end
        end
      end
    end
  end
end
