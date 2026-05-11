# frozen_string_literal: true

require 'spec_helper'
require 'socket'

describe WPScan::Scan do
  subject(:scan) { described_class.new }

  describe '#mask_sensitive_arguments' do
    context 'when handling sensitive arguments' do
      it 'masks API token values' do
        stub_const('ARGV', ['--url', 'http://example.com', '--api-token', 'SECRET_TOKEN_123'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --api-token [REDACTED]')
      end

      it 'masks API token in equals format' do
        stub_const('ARGV', ['--url', 'http://example.com', '--api-token=SECRET_TOKEN_123'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --api-token=[REDACTED]')
      end

      it 'masks HTTP authentication credentials' do
        stub_const('ARGV', ['--url', 'http://example.com', '--http-auth', 'admin:password'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --http-auth [REDACTED]')
      end

      it 'masks proxy authentication credentials' do
        stub_const('ARGV', ['--url', 'http://example.com', '--proxy-auth', 'user:pass'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --proxy-auth [REDACTED]')
      end

      it 'masks cookie strings' do
        stub_const('ARGV', ['--url', 'http://example.com', '--cookie-string', 'session=abc123'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --cookie-string [REDACTED]')
      end

      it 'masks WordPress REST API credentials' do
        stub_const('ARGV', ['--url', 'http://example.com', '--wp-auth', 'admin:xxxx xxxx xxxx xxxx xxxx xxxx'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --wp-auth [REDACTED]')
      end

      it 'masks multiple sensitive arguments' do
        stub_const('ARGV', ['--url', 'http://example.com', '--api-token', 'TOKEN', '--http-auth', 'admin:pass'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --api-token [REDACTED] --http-auth [REDACTED]')
      end
    end

    context 'when handling file paths' do
      it 'does not mask password file paths' do
        stub_const('ARGV', ['--url', 'http://example.com', '--passwords', '/path/to/wordlist.txt'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --passwords /path/to/wordlist.txt')
      end

      it 'does not mask password file paths with -P flag' do
        stub_const('ARGV', ['--url', 'http://example.com', '-P', '/usr/share/wordlists/rockyou.txt'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com -P /usr/share/wordlists/rockyou.txt')
      end

      it 'does not mask cookie jar file paths' do
        stub_const('ARGV', ['--url', 'http://example.com', '--cookie-jar', '/tmp/cookies.txt'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --cookie-jar /tmp/cookies.txt')
      end
    end

    context 'when handling mixed arguments' do
      it 'correctly distinguishes between secrets and file paths' do
        stub_const('ARGV', [
                     '--url', 'http://example.com',
                     '--api-token', 'SECRET',
                     '--passwords', '/path/to/list.txt',
                     '--cookie-jar', '/tmp/cookies.txt',
                     '--http-auth', 'admin:pass'
                   ])
        described_class.new
        expect(WPScan.command_line).to eq(
          '--url http://example.com --api-token [REDACTED] --passwords /path/to/list.txt ' \
          '--cookie-jar /tmp/cookies.txt --http-auth [REDACTED]'
        )
      end
    end

    context 'when no sensitive arguments are present' do
      it 'returns the command line unchanged' do
        stub_const('ARGV', ['--url', 'http://example.com', '--force', '--no-update'])
        described_class.new
        expect(WPScan.command_line).to eq('--url http://example.com --force --no-update')
      end
    end
  end

  describe 'command line capture' do
    it 'captures the command line arguments on initialization' do
      stub_const('ARGV', ['--url', 'http://example.com', '--force'])
      described_class.new
      expect(WPScan.command_line).to eq('--url http://example.com --force')
    end

    it 'stores command line in WPScan module' do
      stub_const('ARGV', ['--test', 'argument'])
      described_class.new
      expect(WPScan).to respond_to(:command_line)
      expect(WPScan.command_line).to be_a(String)
    end
  end
end
