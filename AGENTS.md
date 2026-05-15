# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Project Overview

WPScan is a WordPress security scanner written in Ruby. It provides WordPress-specific scanning capabilities including vulnerability detection, enumeration, and password attacks.

**Key characteristics:**
- Ruby gem with CLI tool
- Architecture based on Controllers, Finders, and Models (MVC-like pattern)
- Uses local database (in `$XDG_CACHE_HOME/wpscan/db` or `~/.cache/wpscan/db`, or `~/.wpscan/db` for existing installations) that syncs with WPScan API
- Scanner framework lives in `lib/wpscan/` (Target, Browser, Controller::Base, Scan, Finders, Formatter, etc.) alongside the WordPress-specific code
- Supports WordPress-specific security scanning features

## Development Best Practices

### Code Style
- **Always run rubocop after making changes** to ensure code style compliance
- Run `bundle exec rubocop -a` to auto-fix issues
- For specific files: `bundle exec rubocop -a file1.rb file2.rb`
- The project uses RuboCop for Ruby style enforcement

## Development Commands

### Setup
```bash
bundle install
```

### Running Tests
```bash
# Run all tests except slow ones (default for PRs)
bundle exec rspec --tag ~slow

# Run full test suite (includes slow tests, only runs on master)
bundle exec rspec

# Run specific test file
bundle exec rspec spec/path/to/file_spec.rb

# Run with coverage
bundle exec rspec  # Coverage enabled by default via .simplecov
```

### Code Quality
```bash
# Run rubocop
bundle exec rubocop

# Auto-fix rubocop issues
bundle exec rubocop -a

# IMPORTANT: Always run rubocop after making code changes
# Run on specific files being modified:
bundle exec rubocop -a path/to/file1.rb path/to/file2.rb
```

### Building
```bash
# Build the gem (runs rubocop & rspec automatically)
bundle exec rake build

# Install gem locally
gem install pkg/wpscan-*.gem
```

### Running WPScan Locally
```bash
# From source (outside git repo to avoid load path conflicts)
ruby -Ilib bin/wpscan --url https://example.com

# Or after installing as gem
wpscan --url https://example.com
```

### Database Operations
```bash
# Update local database
wpscan --update

# The database is stored in $XDG_CACHE_HOME/wpscan/db or ~/.cache/wpscan/db (new installations)
# or ~/.wpscan/db (existing installations)
```

## Architecture

### Core Components

**Entry Point:**
- `bin/wpscan` - CLI executable that chains controllers together
- Controllers are chained using `<<` operator and executed in order

**Controllers (app/controllers/):**
Controllers orchestrate the scanning process. The `Core` controller (app/controllers/core.rb) is implicitly handled by the scanner framework via `WPScan::Scan.new` and runs before the explicitly chained controllers. The explicit chain in bin/wpscan executes in this order:
1. `VulnApi` - API token setup for vulnerability data
2. `CustomDirectories` - Custom wp-content/plugins directory detection
3. `InterestingFindings` - Header analysis, robots.txt, readme files
4. `WpVersion` - WordPress version detection
5. `MainTheme` - Active theme detection
6. `Enumeration` - Plugins, themes, users, etc (see CLI options)
7. `PasswordAttack` - Brute force attacks
8. `Aliases` - Handle legacy CLI options

Note: The `Core` controller handles database updates, WordPress detection, and banner display during the `before_scan` phase.

**Finders (app/finders/):**
Finders implement detection strategies for various WordPress components. Each finder type has multiple strategies (passive, aggressive, mixed):
- `WpVersion` - Detects WordPress version
- `MainTheme` - Detects active theme
- `Plugins` - Plugin enumeration strategies
- `Themes` - Theme enumeration strategies
- `Users` - User enumeration (author ID brute forcing, API endpoints, etc)
- `InterestingFindings` - Backup files, debug logs, etc
- `ConfigBackups` - Config backup file detection (wp-config.php backups)
- `DbExports` - Database export file detection
- `Medias` - Media/attachment enumeration via brute forcing
- `Timthumbs` - Timthumb script detection at known locations
- `Passwords` - Authentication mechanisms (wp-login, XML-RPC)

**Models (app/models/):**
Domain objects representing WordPress components:
- `WpItem` - Base class for plugins/themes
- `Plugin`, `Theme` - Specific WordPress items
- `WpVersion` - WordPress version with vulnerability info
- `InterestingFinding` - Security-relevant findings
- `ConfigBackup` - Detected wp-config.php backup files
- `DbExport` - Detected database export files
- `Media` - Media attachments found on the site
- `Timthumb` - Timthumb script instances
- `XMLRPC` - XML-RPC interface details

**Database (lib/wpscan/db/):**
- `Updater` - Syncs local database with WPScan API
- `VulnApi` - API client for vulnerability data
- `DynamicFinders` - Auto-generated finders from database metadata
- `Fingerprints` - Version detection fingerprints
- Database stored in `$XDG_CACHE_HOME/wpscan/db/` or `~/.cache/wpscan/db/` (new installations) or `~/.wpscan/db/` (existing installations) by default (overridden in specs to `spec/fixtures/db/`)

### Important Patterns

**Scanner framework:**
The scanner framework lives under `WPScan::` alongside the WordPress-specific code. Core framework classes — `WPScan::Target`, `WPScan::Browser`, `WPScan::Controller::{Base,Core}`, `WPScan::ParsedCli`, `WPScan::Vulnerability`, `WPScan::Model::{InterestingFinding,XMLRPC}`, etc. — are single unified classes, not split across framework/WordPress layers. WordPress-specific behavior is mixed in via modules (e.g. `WPScan::Target::Platform::WordPress` is included into `WPScan::Target`). Option parsing delegates to the external `opt_parse_validator` gem.

**Dynamic Finders:**
Finders can be dynamically generated from database metadata (see `lib/wpscan/db/dynamic_finders/`). This allows version detection strategies to be data-driven.

**Slug Classification:**
WordPress slugs (plugin/theme names) are converted to Ruby class names via `classify_slug` helper (lib/wpscan/helper.rb). Handles edge cases:
- Slugs starting with digits get prefixed with `D_` (e.g., `123-plugin` becomes `D_123Plugin`)
- Special characters are converted to underscores
- Slugs with all non-latin characters become `HexSlug_` followed by hex-encoded bytes

**API Requests Tracking:**
The codebase tracks API requests via `WPScan.api_requests` class variable to monitor usage against API limits.

## Testing

### Test Structure
- Tests use RSpec with WebMock for HTTP stubbing
- Fixtures in `spec/fixtures/`
- Shared examples in `spec/shared_examples/`
- Coverage via SimpleCov (configured in `.simplecov`)

### Key Testing Helpers (spec/spec_helper.rb)
- `rspec_parsed_options(args)` - Parse CLI arguments
- `df_expected_all` - Dynamic finder test expectations
- `vuln_api_data_for(path)` - Load vulnerability API fixtures
- `redefine_constant(constant, value)` - Override WPScan constants for testing

### Test Tags
- `--tag ~slow` - Excludes slow tests (default for CI on PRs)
- Full suite runs only on master pushes

## Common Gotchas

**Active Support Must Be First:**
`active_support/all` must be required before other gems to avoid encoding issues with JSON (see lib/wpscan.rb:4-6).

**Running Outside Git Repo:**
When using `wpscan` from source, run it outside the git repo to avoid load path conflicts.

**Database Location:**
Tests override `DB_DIR` to `spec/fixtures/db/`. Production uses `$XDG_CACHE_HOME/wpscan/db` or `~/.cache/wpscan/db` (new installations) or `~/.wpscan/db` (existing installations).

**Port Normalization:**
WebMock adapter has custom port normalization for Typhoeus (spec/spec_helper.rb:63-96) to handle default ports.

## API Integration

**WPScan API:**
- Requires API token (via `--api-token` or `WPSCAN_API_TOKEN` env var or config file)
- Free tier: 25 requests/day
- One request per WordPress version, plugin, and theme detected
- Response tracking via `Typhoeus.on_complete` hook in lib/wpscan.rb

**Configuration Files:**
WPScan loads options from (in order):
1. `$XDG_CONFIG_HOME/wpscan/scan.json` or `$XDG_CONFIG_HOME/wpscan/scan.yml` (if `XDG_CONFIG_HOME` is set)
2. `~/.config/wpscan/scan.json` or `~/.config/wpscan/scan.yml` (if `XDG_CONFIG_HOME` is not set)
3. `~/.wpscan/scan.json` or `~/.wpscan/scan.yml`
4. `pwd/.wpscan/scan.json` or `pwd/.wpscan/scan.yml`

Use snake_case for CLI options in config (e.g., `api_token`, `max_threads`).
