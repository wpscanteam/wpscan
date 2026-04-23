#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

# Integration test verification script
# Verifies that WPScan correctly detects known vulnerabilities in test WordPress site

results_file = ARGV[0]

unless results_file && File.exist?(results_file)
  puts 'Error: Please provide a valid scan results JSON file'
  exit 1
end

results = JSON.parse(File.read(results_file))

# Expected plugins with vulnerabilities
EXPECTED_VULNERABLE_PLUGINS = {
  'contact-form-7' => {
    version: '5.3.2',
    min_vulns: 1,
    description: 'Contact Form 7 5.3.2 (CVE-2020-35489 XSS)'
  },
  'elementor' => {
    version: '3.1.3',
    min_vulns: 1,
    description: 'Elementor 3.1.3 (authenticated stored XSS)'
  },
  'woocommerce' => {
    version: '4.6.1',
    min_vulns: 1,
    description: 'WooCommerce 4.6.1 (CVE-2021-32789 SQL injection)'
  },
  'wordpress-seo' => {
    version: '15.5',
    min_vulns: 1,
    description: 'Yoast SEO 15.5 (XSS vulnerability)'
  }
}.freeze

# Expected theme vulnerabilities
EXPECTED_VULNERABLE_THEMES = {
  'twentynineteen' => {
    version: '1.8',
    min_vulns: 1,
    description: 'Twenty Nineteen 1.8'
  }
}.freeze

failures = []
warnings = []

puts '=' * 80
puts 'WPScan Integration Test - Verification Results'
puts '=' * 80
puts

# Verify WordPress was detected
if results['version'].nil?
  failures << 'WordPress version not detected'
else
  wp_version = results['version']['number']
  puts "✓ WordPress detected: #{wp_version}"
end

puts

# Verify plugins were detected
puts 'Plugin Detection & Vulnerability Check:'
puts '-' * 80

EXPECTED_VULNERABLE_PLUGINS.each do |slug, expectations|
  plugin_data = results.dig('plugins', slug)

  if plugin_data.nil?
    failures << "Plugin '#{slug}' not detected (#{expectations[:description]})"
    puts "✗ #{slug}: NOT DETECTED"
    next
  end

  detected_version = plugin_data.dig('version', 'number')
  vulns = plugin_data['vulnerabilities'] || []

  # Check version detection
  if detected_version.nil?
    warnings << "Plugin '#{slug}' detected but version not identified"
    puts "⚠ #{slug}: Detected but version unknown (expected #{expectations[:version]})"
  elsif detected_version != expectations[:version]
    failures << "Expected #{slug} version #{expectations[:version]}, got #{detected_version}"
    puts "✗ #{slug}: Wrong version (expected #{expectations[:version]}, got #{detected_version})"
  else
    puts "✓ #{slug}: Version #{detected_version} detected"
  end

  # Check vulnerabilities
  if vulns.length < expectations[:min_vulns]
    failures << "Expected at least #{expectations[:min_vulns]} vulnerabilities for #{slug}, found #{vulns.length}"
    puts "  ✗ Vulnerabilities: Found #{vulns.length}, expected at least #{expectations[:min_vulns]}"
  else
    puts "  ✓ Vulnerabilities: Found #{vulns.length} (expected at least #{expectations[:min_vulns]})"
    vulns.first(3).each do |vuln|
      title = vuln['title'] || 'Unknown'
      puts "    - #{title}"
    end
  end
end

puts

# Verify themes were detected
puts 'Theme Detection & Vulnerability Check:'
puts '-' * 80

EXPECTED_VULNERABLE_THEMES.each do |slug, expectations|
  theme_data = results.dig('themes', slug)

  if theme_data.nil?
    failures << "Theme '#{slug}' not detected (#{expectations[:description]})"
    puts "✗ #{slug}: NOT DETECTED"
    next
  end

  detected_version = theme_data.dig('version', 'number')
  vulns = theme_data['vulnerabilities'] || []

  # Check version detection
  if detected_version.nil?
    warnings << "Theme '#{slug}' detected but version not identified"
    puts "⚠ #{slug}: Detected but version unknown (expected #{expectations[:version]})"
  elsif detected_version != expectations[:version]
    failures << "Expected #{slug} version #{expectations[:version]}, got #{detected_version}"
    puts "✗ #{slug}: Wrong version (expected #{expectations[:version]}, got #{detected_version})"
  else
    puts "✓ #{slug}: Version #{detected_version} detected"
  end

  # Check vulnerabilities
  if vulns.length < expectations[:min_vulns]
    failures << "Expected at least #{expectations[:min_vulns]} vulnerabilities for #{slug}, found #{vulns.length}"
    puts "  ✗ Vulnerabilities: Found #{vulns.length}, expected at least #{expectations[:min_vulns]}"
  else
    puts "  ✓ Vulnerabilities: Found #{vulns.length} (expected at least #{expectations[:min_vulns]})"
    vulns.first(3).each do |vuln|
      title = vuln['title'] || 'Unknown'
      puts "    - #{title}"
    end
  end
end

puts
puts '=' * 80

# Display summary
if warnings.any?
  puts
  puts 'Warnings:'
  warnings.each { |w| puts "  ⚠ #{w}" }
end

if failures.any?
  puts
  puts 'FAILED - Integration test failures:'
  failures.each { |f| puts "  ✗ #{f}" }
  puts
  exit 1
else
  puts
  puts '✓ All integration tests passed!'
  puts
  exit 0
end
