# frozen_string_literal: true

require 'spec_helper'

describe 'UUID Exclusion for WP Version' do
  before do
    # Save original CLI options
    @original_options = WPScan::ParsedCli.options.dup
  end

  after do
    # Restore original CLI options
    WPScan::ParsedCli.options = @original_options
  end

  describe 'WpVersion with excluded UUIDs' do
    subject(:wp_version) { WPScan::Model::WpVersion.new('3.8.1', opts) }
    let(:opts) { {} }

    let(:vuln_data) do
      vuln_api_data_for('wordpresses/381')
    end

    before do
      allow(wp_version).to receive(:db_data).and_return(vuln_data)
    end

    context 'without exclusions' do
      it 'returns all vulnerabilities' do
        expect(wp_version.vulnerabilities.size).to eq(2)
        expect(wp_version.vulnerable?).to be true
      end
    end

    context 'with UUID exclusions' do
      before do
        WPScan::ParsedCli.options = { exclude_vulns: ['c099c1da-3750-4e63-8af9-929e773bbe57'] }
      end

      it 'filters out excluded UUIDs' do
        expect(wp_version.filtered_vulnerabilities.size).to eq(1)
        expect(wp_version.filtered_vulnerabilities.first.title).to eq('WP 3.8.1 - Vuln 2')
      end

      it 'still reports as vulnerable if non-excluded vulnerabilities exist' do
        expect(wp_version.vulnerable?).to be true
      end
    end

    context 'with all UUIDs excluded' do
      before do
        WPScan::ParsedCli.options = {
          exclude_vulns: %w[c099c1da-3750-4e63-8af9-929e773bbe57 d099c1da-3750-4e63-8af9-929e773bbe58]
        }
      end

      it 'returns no vulnerabilities' do
        expect(wp_version.filtered_vulnerabilities).to be_empty
      end

      it 'reports as not vulnerable' do
        expect(wp_version.vulnerable?).to be false
      end
    end

    context 'with case-insensitive UUID matching' do
      before do
        WPScan::ParsedCli.options = { exclude_vulns: ['C099C1DA-3750-4E63-8AF9-929E773BBE57'] }
      end

      it 'matches UUIDs regardless of case' do
        expect(wp_version.filtered_vulnerabilities.size).to eq(1)
      end
    end
  end
end
