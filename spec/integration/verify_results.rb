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
# NOTE: Using passive detection, so only plugins referenced on the homepage are detected.
# Elementor is not included because it's not passively detected (not referenced on homepage).
EXPECTED_VULNERABLE_PLUGINS = {
  'contact-form-7' => {
    version: '5.3.2',
    min_vulns: 1,
    description: 'Contact Form 7 5.3.2 (CVE-2020-35489 XSS)'
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

# Expected theme detection
# NOTE: Theme is detected but may not have vulnerabilities in the database
EXPECTED_THEME = {
  slug: 'twentynineteen',
  version: '1.8',
  description: 'Twenty Nineteen 1.8'
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
puts 'Theme Detection:'
puts '-' * 80

theme_data = results['main_theme']

if theme_data.nil?
  failures << "Theme not detected (expected #{EXPECTED_THEME[:description]})"
  puts '✗ Theme: NOT DETECTED'
else
  detected_slug = theme_data['slug']
  detected_version = theme_data.dig('version', 'number')

  if detected_slug != EXPECTED_THEME[:slug]
    failures << "Expected theme #{EXPECTED_THEME[:slug]}, got #{detected_slug}"
    puts "✗ Theme: Wrong theme (expected #{EXPECTED_THEME[:slug]}, got #{detected_slug})"
  elsif detected_version.nil?
    warnings << 'Theme detected but version not identified'
    puts "⚠ #{detected_slug}: Detected but version unknown (expected #{EXPECTED_THEME[:version]})"
  elsif detected_version != EXPECTED_THEME[:version]
    failures << "Expected #{detected_slug} version #{EXPECTED_THEME[:version]}, got #{detected_version}"
    puts "✗ #{detected_slug}: Wrong version (expected #{EXPECTED_THEME[:version]}, got #{detected_version})"
  else
    vulns = theme_data['vulnerabilities'] || []
    puts "✓ #{detected_slug}: Version #{detected_version} detected"
    puts "  ℹ Vulnerabilities: Found #{vulns.length} (theme vulnerabilities not required for this test)"
  end
end

puts

# Verify user enumeration
puts 'User Enumeration:'
puts '-' * 80

EXPECTED_USERS = %w[admin editor1 author1].freeze
detected_users = (results['users'] || {}).keys

EXPECTED_USERS.each do |username|
  if detected_users.include?(username)
    puts "✓ User detected: #{username}"
  else
    failures << "User '#{username}' not detected"
    puts "✗ User: #{username} NOT DETECTED"
  end
end

puts

# Verify config backup, db export, and timthumb finders
puts 'Config Backups / DB Exports / Timthumbs:'
puts '-' * 80

{
  'config_backups' => 'wp-config.bak',
  'db_exports' => 'backup.sql',
  'timthumbs' => 'timthumb.php'
}.each do |section, expected_filename|
  entries = (results[section] || {}).keys
  if entries.any? { |url| url.include?(expected_filename) }
    puts "✓ #{section}: found entry matching '#{expected_filename}'"
  else
    failures << "#{section}: expected entry matching '#{expected_filename}', got #{entries.inspect}"
    puts "✗ #{section}: no entry matching '#{expected_filename}' (found: #{entries.inspect})"
  end
end

puts

# Verify interesting findings the test environment is set up to expose.
# Types are derived from the model class name via demodulize.underscore:
# DebugLog -> debug_log, Readme -> readme, WPCron -> wp_cron.
puts 'Interesting Findings:'
puts '-' * 80

EXPECTED_FINDING_TYPES = %w[
  debug_log
  readme
  wp_cron
  registration
  mu_plugins
  backup_db
  duplicator_installer_log
  emergency_pwd_reset_script
  search_replace_db2
  fantastico_fileslist
  upload_sql_dump
].freeze
finding_types = (results['interesting_findings'] || []).map { |f| f['type'] }

EXPECTED_FINDING_TYPES.each do |type|
  if finding_types.include?(type)
    puts "✓ Interesting finding: #{type}"
  else
    failures << "Interesting finding '#{type}' not reported"
    puts "✗ Interesting finding: #{type} NOT REPORTED (got: #{finding_types.inspect})"
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

puts
if failures.any?
  puts 'FAILED - Integration test failures:'
  failures.each { |f| puts "  ✗ #{f}" }
  puts
  exit 1
else
  puts '✓ All integration tests passed!'
  puts
  exit 0
end
