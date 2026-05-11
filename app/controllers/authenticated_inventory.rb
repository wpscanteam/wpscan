# frozen_string_literal: true

module WPScan
  module Controller
    # Fetches an authoritative inventory of installed plugins and themes from the
    # WordPress REST API using admin credentials (--wp-auth). Pre-populates the
    # target's @plugins / @themes / @main_theme so the regular enumeration
    # controllers skip detection for those items.
    class AuthenticatedInventory < WPScan::Controller::Base
      def run
        return unless ParsedCli.wp_auth

        output('@info', msg: 'Fetching authoritative inventory via WP REST API (/wp-json/wp/v2/)') if user_interaction?

        plugins = plugins_finder.aggressive(userpwd: userpwd)
        themes  = themes_finder.aggressive(userpwd: userpwd)

        target.instance_variable_set(:@plugins, plugins)
        target.instance_variable_set(:@themes, themes)

        active = themes.find { |t| t.instance_variable_get(:@wp_json_active) }
        target.instance_variable_set(:@main_theme, active) if active

        formatter.output('plugins', { plugins: plugins, verbose: ParsedCli.verbose }, 'enumeration')
        formatter.output('themes',  { themes: themes, verbose: ParsedCli.verbose }, 'enumeration')
      end

      private

      def plugins_finder
        @plugins_finder ||= Finders::Plugins::WpJsonApi.new(target)
      end

      def themes_finder
        @themes_finder ||= Finders::Themes::WpJsonApi.new(target)
      end

      def userpwd
        "#{ParsedCli.wp_auth[:username]}:#{ParsedCli.wp_auth[:password]}"
      end
    end
  end
end
