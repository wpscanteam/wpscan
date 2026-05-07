# frozen_string_literal: true

require 'digest'

module WPScan
  module Formatter
    # SARIF v2.1.0 Formatter.
    #
    # Emits scan results in SARIF v2.1.0 format so they can be consumed by
    # static-analysis aggregators such as GitHub Code Scanning. WPScan is a
    # DAST tool, so findings don't have a source file + line; we follow the
    # mapping discussed on issue #1879:
    #
    #   * `result.locations[].physicalLocation.artifactLocation.uri` carries
    #     the URL where the finding was observed. SARIF explicitly allows
    #     `uri` to be an absolute URL — see SARIF v2.1.0 §3.4.3
    #     (https://docs.oasis-open.org/sarif/sarif/v2.1.0/os/sarif-v2.1.0-os.html#_Toc34317419).
    #   * `result.locations[].logicalLocations[]` carries the WordPress
    #     component identity (core / plugin <slug> / theme <slug>) decoupled
    #     from any URL — see SARIF v2.1.0 §3.33
    #     (https://docs.oasis-open.org/sarif/sarif/v2.1.0/os/sarif-v2.1.0-os.html#_Toc34317719).
    #
    # GitHub's guidance on which SARIF fields surface in Code Scanning is
    # at https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/sarif-support-for-code-scanning.
    #
    # This formatter inherits from {Json} and reuses the JSON ERB views: the
    # full scan is buffered as JSON during the run, then transformed into a
    # SARIF document in {#beautify}. Reusing the JSON layer keeps the SARIF
    # mapping in one place and lets new JSON fields flow through automatically.
    class Sarif < Json
      SARIF_VERSION = '2.1.0'
      SARIF_SCHEMA  = 'https://json.schemastore.org/sarif-2.1.0.json'
      INFO_URI      = 'https://wpscan.com/wordpress-security-scanner'

      # Make ERB lookups fall back to the json/* views.
      def base_format
        'json'
      end

      def beautify
        data = JSON.parse("{#{buffer.chomp.chomp(',')}}")
        puts JSON.pretty_generate(sarif_document(data))
      end

      private

      def sarif_document(data)
        rules   = {}
        results = []

        collect_vulnerability_results(data, rules, results)
        collect_interesting_finding_results(data, rules, results)

        {
          '$schema' => SARIF_SCHEMA,
          'version' => SARIF_VERSION,
          'runs' => [build_run(data, rules, results)]
        }
      end

      def build_run(data, rules, results)
        {
          'tool' => {
            'driver' => {
              'name' => 'WPScan',
              'version' => WPScan::VERSION,
              'informationUri' => INFO_URI,
              'rules' => rules.values
            }
          },
          'invocations' => [invocation(data)].compact,
          'results' => results,
          'properties' => run_properties(data)
        }.compact
      end

      def collect_vulnerability_results(data, rules, results)
        components(data).each do |component|
          Array(component[:vulnerabilities]).each do |vuln|
            rule_id = rule_id_for(vuln)
            rules[rule_id] ||= rule_for(vuln, rule_id)
            results << vulnerability_result(vuln, rule_id, component)
          end
        end
      end

      def collect_interesting_finding_results(data, rules, results)
        Array(data['interesting_findings']).each do |finding|
          rule_id = "wpscan.interesting-finding.#{finding['type'] || 'unknown'}"
          rules[rule_id] ||= interesting_finding_rule(rule_id, finding)
          results << interesting_finding_result(finding, rule_id)
        end
      end

      # @return [ Array<Hash> ] one entry per WordPress component observed
      def components(data)
        list = []
        list << core_component(data) if data['version']
        list << theme_component(data['main_theme']) if data['main_theme']
        (data['themes'] || {}).each_value { |theme| list << theme_component(theme) }
        (data['plugins'] || {}).each { |slug, plugin| list << plugin_component(slug, plugin) }
        list
      end

      def core_component(data)
        {
          kind: 'core',
          slug: nil,
          version: data['version']['number'],
          url: data['effective_url'] || data['target_url'],
          vulnerabilities: data['version']['vulnerabilities']
        }
      end

      def plugin_component(slug, plugin)
        {
          kind: 'plugin',
          slug: slug,
          version: plugin.dig('version', 'number'),
          url: plugin['location'],
          vulnerabilities: plugin['vulnerabilities']
        }
      end

      def theme_component(theme)
        {
          kind: 'theme',
          slug: theme['slug'],
          version: theme.dig('version', 'number'),
          url: theme['location'],
          vulnerabilities: theme['vulnerabilities']
        }
      end

      def rule_id_for(vuln)
        cve = Array(vuln.dig('references', 'cve')).first
        return "CVE-#{cve}" if cve

        wpvulndb = Array(vuln.dig('references', 'wpvulndb')).first
        return "WPVULNDB-#{wpvulndb}" if wpvulndb

        # Stable fallback so we don't emit duplicate rule entries for the same title.
        "wpscan.vuln.#{Digest::SHA1.hexdigest(vuln['title'].to_s)[0, 12]}"
      end

      def rule_for(vuln, rule_id)
        title = vuln['title'].to_s
        {
          'id' => rule_id,
          'name' => rule_id.gsub(/[^A-Za-z0-9_]/, '_'),
          'shortDescription' => { 'text' => title },
          'fullDescription' => { 'text' => title },
          'helpUri' => help_uri_for(vuln),
          'defaultConfiguration' => { 'level' => level_for(vuln) },
          'messageStrings' => {
            # {0} = component label (e.g. "Plugin 'foo' 1.2.3"), {1} = fix status.
            # Title is baked in here so the rule owns its phrasing and the result
            # message stays small (SARIF2002). Dynamic args are single-quoted per
            # SARIF2015 and the message terminates with a period per SARIF2001.
            'default' => { 'text' => "'{0}': #{title} ('{1}')." }
          },
          'properties' => rule_properties(vuln)
        }.compact
      end

      def vulnerability_result(vuln, rule_id, component)
        {
          'ruleId' => rule_id,
          'level' => level_for(vuln),
          'message' => {
            'id' => 'default',
            'arguments' => [component_label(component), fix_status(vuln)]
          },
          'locations' => [location_for(component[:url], logical_location(component))]
        }
      end

      def interesting_finding_rule(rule_id, finding)
        {
          'id' => rule_id,
          'name' => rule_id.gsub(/[^A-Za-z0-9_]/, '_'),
          'shortDescription' => { 'text' => "Interesting finding: #{finding['type']}" },
          # Non-vulnerability findings (enumeration results, headers, robots.txt entries,
          # etc.) are emitted at `note` level so they don't drown out real vulnerabilities
          # in Code Scanning's UI — see GitHub's SARIF support guidance.
          'defaultConfiguration' => { 'level' => 'note' },
          'messageStrings' => {
            # {0} = finding header (to_s), {1} = interesting entries joined,
            # {2} = found-by strategy, {3} = confidence percentage.
            'default' => {
              'text' => "'{0}' — entries: '{1}'; found by: '{2}'; confidence: '{3}'."
            }
          },
          'helpUri' => INFO_URI
        }
      end

      def interesting_finding_result(finding, rule_id)
        location = location_for(finding['url'], nil)
        entries = Array(finding['interesting_entries']).join(' | ')
        {
          'ruleId' => rule_id,
          'level' => 'note',
          'message' => {
            'id' => 'default',
            'arguments' => [
              finding['to_s'].to_s,
              entries,
              finding['found_by'].to_s,
              finding['confidence'].to_s
            ]
          },
          'locations' => location ? [location] : []
        }
      end

      def location_for(url, logical)
        physical = physical_location(url)
        return nil if physical.nil? && logical.nil?

        loc = {}
        loc['physicalLocation'] = physical if physical
        loc['logicalLocations'] = [logical] if logical
        loc
      end

      def physical_location(url)
        return nil if url.nil? || url.to_s.empty?

        { 'artifactLocation' => { 'uri' => url.to_s } }
      end

      def logical_location(component)
        fqn = case component[:kind]
              when 'core'   then "wordpress.core@#{component[:version] || 'unknown'}"
              when 'theme'  then "wordpress.theme.#{component[:slug]}@#{component[:version] || 'unknown'}"
              when 'plugin' then "wordpress.plugin.#{component[:slug]}@#{component[:version] || 'unknown'}"
              end

        {
          'name' => component[:slug] || component[:kind],
          'fullyQualifiedName' => fqn,
          'kind' => 'module'
        }
      end

      # Map CVSS v3 base score to a SARIF level. Vulnerabilities without a
      # score default to `error` since WPScan only flags entries the WPScan
      # vulnerability database considers exploitable.
      def level_for(vuln)
        score = vuln.dig('cvss', 'score').to_f
        return 'error'   if score >= 7.0
        return 'warning' if score >= 4.0
        return 'note'    if score.positive?

        'error'
      end

      def component_label(component)
        case component[:kind]
        when 'core'   then "WordPress core #{component[:version]}"
        when 'theme'  then "Theme '#{component[:slug]}' #{component[:version]}"
        when 'plugin' then "Plugin '#{component[:slug]}' #{component[:version]}"
        end
      end

      def fix_status(vuln)
        vuln['fixed_in'] ? "fixed in #{vuln['fixed_in']}" : 'no fix available'
      end

      def help_uri_for(vuln)
        wpvulndb = Array(vuln.dig('references', 'wpvulndb')).first
        return "https://wpscan.com/vulnerability/#{wpvulndb}" if wpvulndb

        Array(vuln.dig('references', 'url')).first
      end

      def rule_properties(vuln)
        props = {}
        props['cvss'] = vuln['cvss'] if vuln['cvss']
        props['references'] = vuln['references'] if vuln['references'] && !vuln['references'].empty?
        props['fixed_in'] = vuln['fixed_in'] if vuln['fixed_in']
        props['poc'] = vuln['poc'] if vuln['poc']
        props.empty? ? nil : props
      end

      def invocation(data)
        inv = { 'executionSuccessful' => true }
        inv['commandLine'] = "wpscan #{data['command_line']}" if data['command_line']
        inv['hostname'] = data['hostname'] if data['hostname']
        inv['startTimeUtc'] = to_iso8601(data['start_time']) if data['start_time']
        inv['endTimeUtc']   = to_iso8601(data['stop_time'])  if data['stop_time']
        inv
      end

      def run_properties(data)
        props = {}
        props['targetUrl']    = data['target_url']    if data['target_url']
        props['effectiveUrl'] = data['effective_url'] if data['effective_url']
        props['targetIp']     = data['target_ip']     if data['target_ip']
        props.empty? ? nil : props
      end

      def to_iso8601(epoch)
        return nil if epoch.nil? || epoch.to_i.zero?

        Time.at(epoch.to_i).utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
      end
    end
  end
end
