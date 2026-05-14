# frozen_string_literal: true

module WPScan
  module Controller
    # Enumeration Methods
    class Enumeration < WPScan::Controller::Base
      # @return [ Boolean ] Whether enumeration findings should be streamed
      #   as they are discovered rather than batched at end of step. Streaming
      #   requires both a streaming-capable formatter (cli, cli_no_color, jsonl)
      #   and the user not having opted out via --no-stream.
      def stream_findings?
        formatter.streams? && ParsedCli.stream != false
      end

      # @param [ String ] type (plugins or themes)
      # @param [ Symbol ] detection_mode
      #
      # @return [ String ] The related enumration message depending on the ParsedCli and type supplied
      def enum_message(type, detection_mode)
        return unless %w[plugins themes].include?(type)

        enumerate = ParsedCli.enumerate || {}
        details = if enumerate[:"vulnerable_#{type}"]
                    'Vulnerable'
                  elsif enumerate[:"all_#{type}"]
                    'All'
                  else
                    'Most Popular'
                  end

        "Enumerating #{details} #{type.capitalize} #{enum_detection_message(detection_mode)}"
      end

      # @param [ Symbol ] detection_mode
      #
      # @return [ String ]
      def enum_detection_message(detection_mode)
        detection_method = if detection_mode == :mixed
                             'Passive and Aggressive'
                           else
                             detection_mode.to_s.capitalize
                           end

        "(via #{detection_method} Methods)"
      end

      # @param [ String ] type (plugins, themes etc)
      #
      # @return [ Hash ]
      def default_opts(type)
        mode = ParsedCli.options[:"#{type}_detection"] || ParsedCli.detection_mode

        {
          mode: mode,
          exclude_content: ParsedCli.exclude_content_based,
          show_progression: user_interaction?,
          version_detection: {
            mode: ParsedCli.options[:"#{type}_version_detection"] || mode,
            confidence_threshold: ParsedCli.options[:"#{type}_version_all"] ? 0 : 100
          }
        }
      end

      # Resolves collisions between --plugins-list/--themes-list and the
      # corresponding --enumerate choices. The list options take precedence;
      # colliding enumerate keys are removed from the supplied hash and a
      # notice is emitted for each ignored choice.
      #
      # @param [ Hash ] enum The ParsedCli.enumerate hash (mutated in place)
      def resolve_list_enumerate_collisions(enum)
        {
          plugins_list: %i[vulnerable_plugins all_plugins popular_plugins],
          themes_list: %i[vulnerable_themes all_themes popular_themes]
        }.each do |list_opt, enum_keys|
          next unless ParsedCli.send(list_opt)

          ignored = enum_keys.select { |k| enum.key?(k) }
          next if ignored.empty?

          ignored.each { |k| enum.delete(k) }

          output(
            '@notice',
            msg: "--#{list_opt.to_s.tr('_', '-')} provided; " \
                 "ignoring colliding --enumerate choice(s): #{ignored.join(', ')}"
          )
        end
      end

      # Suppresses plugin/theme --enumerate choices and --plugins-list / --themes-list
      # when --wp-auth was supplied, since AuthenticatedInventory already populated
      # the target with authoritative data.
      #
      # @param [ Hash ] enum The enumeration hash, mutated in place.
      def suppress_plugin_theme_choices_when_authenticated(enum)
        return unless ParsedCli.wp_auth

        suppressed = enum.keys & WP_AUTH_SUPPRESSED_CHOICES
        suppressed.each { |k| enum.delete(k) }

        lists_suppressed = %i[plugins_list themes_list].select { |opt| ParsedCli.send(opt) }
        return if suppressed.empty? && lists_suppressed.empty?

        ignored = (suppressed + lists_suppressed.map { |o| "--#{o.to_s.tr('_', '-')}" }).join(', ')
        output('@notice',
               msg: "--wp-auth provided; ignoring plugin/theme enumeration option(s): #{ignored} " \
                    '(authoritative inventory already retrieved via the WP REST API).')
      end

      # @param [ Hash ] opts
      #
      # @return [ Boolean ] Wether or not to enumerate the plugins
      def enum_plugins?(opts)
        return false if ParsedCli.wp_auth

        ParsedCli.plugins_list || opts[:popular_plugins] || opts[:all_plugins] || opts[:vulnerable_plugins]
      end

      def enum_plugins
        opts = default_opts('plugins').merge(
          list: plugins_list_from_opts(ParsedCli.options),
          threshold: ParsedCli.plugins_threshold,
          sort: true
        )

        output('@info', msg: enum_message('plugins', opts[:mode])) if user_interaction?

        enum_wp_items(
          'plugin', target_method: :plugins, opts: opts,
                    only_vulnerable: ParsedCli.enumerate&.dig(:vulnerable_plugins)
        )
      end

      # @param [ Hash ] opts
      #
      # @return [ Array<String> ] The plugins list associated to the cli options
      def plugins_list_from_opts(opts)
        # List file provided by the user via the cli
        return opts[:plugins_list] if opts[:plugins_list]

        if opts[:enumerate][:all_plugins]
          DB::Plugins.all_slugs
        elsif opts[:enumerate][:popular_plugins]
          DB::Plugins.popular_slugs
        else
          DB::Plugins.vulnerable_slugs
        end
      end

      # @param [ Hash ] opts
      #
      # @return [ Boolean ] Wether or not to enumerate the themes
      def enum_themes?(opts)
        return false if ParsedCli.wp_auth

        ParsedCli.themes_list || opts[:popular_themes] || opts[:all_themes] || opts[:vulnerable_themes]
      end

      def enum_themes
        opts = default_opts('themes').merge(
          list: themes_list_from_opts(ParsedCli.options),
          threshold: ParsedCli.themes_threshold,
          sort: true
        )

        output('@info', msg: enum_message('themes', opts[:mode])) if user_interaction?

        enum_wp_items(
          'theme', target_method: :themes, opts: opts,
                   only_vulnerable: ParsedCli.enumerate&.dig(:vulnerable_themes)
        )
      end

      # Shared plugins/themes enumeration body. Streams per-item output when
      # the active formatter supports it (and --no-stream wasn't passed),
      # otherwise batches the result and renders the plural view.
      #
      # @param [ String ] singular  'plugin' or 'theme' (view name)
      # @param [ Symbol ] target_method  :plugins or :themes
      # @param [ Hash ] opts  Options forwarded to the target call
      # @param [ Boolean ] only_vulnerable  Filter to vulnerable items only
      def enum_wp_items(singular, target_method:, opts:, only_vulnerable:)
        stream = stream_findings?

        items = target.send(target_method, opts) do |item|
          stream_wp_item(item, singular: singular, only_vulnerable: only_vulnerable) if stream
        end

        finalize_wp_items_output(items, singular: singular, opts: opts, stream: stream,
                                        only_vulnerable: only_vulnerable)
      end

      def finalize_wp_items_output(items, singular:, opts:, stream:, only_vulnerable:)
        plural = "#{singular}s"

        if !stream && user_interaction? && !items.empty?
          mode_msg = enum_detection_message(opts[:version_detection][:mode])
          output('@info', msg: "Checking #{singular.capitalize} Versions #{mode_msg}")
        end

        items.each(&:version) unless stream
        items.select!(&:vulnerable?) if only_vulnerable

        if stream
          summary = items.empty? ? "No #{plural} Found." : "#{items.size} #{singular}(s) Identified."
          output('@notice', msg: summary)
        else
          output(plural, plural.to_sym => items)
        end
      end

      def stream_wp_item(item, singular:, only_vulnerable:)
        item.version
        return if only_vulnerable && !item.vulnerable?

        output(singular, singular.to_sym => item)
      end

      # @param [ Hash ] opts
      #
      # @return [ Array<String> ] The themes list associated to the cli options
      def themes_list_from_opts(opts)
        # List file provided by the user via the cli
        return opts[:themes_list] if opts[:themes_list]

        if opts[:enumerate][:all_themes]
          DB::Themes.all_slugs
        elsif opts[:enumerate][:popular_themes]
          DB::Themes.popular_slugs
        else
          DB::Themes.vulnerable_slugs
        end
      end

      def enum_timthumbs
        opts = { list: ParsedCli.timthumbs_list, show_progression: user_interaction? }

        output('@info', msg: 'Enumerating Timthumbs') if user_interaction?
        output('timthumbs', timthumbs: target.timthumbs(opts))
      end

      def enum_config_backups
        opts = { list: ParsedCli.config_backups_list, show_progression: user_interaction? }

        output('@info', msg: 'Enumerating Config Backups') if user_interaction?
        output('config_backups', config_backups: target.config_backups(opts))
      end

      def enum_db_exports
        opts = { list: ParsedCli.db_exports_list, show_progression: user_interaction? }

        output('@info', msg: 'Enumerating DB Exports') if user_interaction?
        output('db_exports', db_exports: target.db_exports(opts))
      end

      def enum_backup_folders
        opts = { list: ParsedCli.backup_folders_list, show_progression: user_interaction? }

        output('@info', msg: 'Enumerating Backup Folders') if user_interaction?
        output('backup_folders', backup_folders: target.backup_folders(opts))
      end

      def enum_medias
        opts = { range: ParsedCli.enumerate[:medias], show_progression: user_interaction? }

        if user_interaction?
          output('@info',
                 msg: 'Enumerating Medias (Permalink setting must be set to "Plain" for those to be detected)')
        end

        output('medias', medias: target.medias(opts))
      end

      # @param [ Hash ] opts
      #
      # @return [ Boolean ] Wether or not to enumerate the users
      def enum_users?(opts)
        opts[:users] || (ParsedCli.passwords && !ParsedCli.username && !ParsedCli.usernames)
      end

      def enum_users
        opts = default_opts('users').merge(
          range: enum_users_range,
          list: ParsedCli.users_list
        )

        output('@info', msg: "Enumerating Users #{enum_detection_message(opts[:mode])}") if user_interaction?

        stream = stream_findings?
        exclude = ParsedCli.exclude_usernames

        users = target.users(opts) do |user|
          next unless stream
          next if exclude&.match?(user.username)

          output('user', user: user)
        end || []

        if stream
          output('@notice', msg: users.empty? ? 'No Users Found.' : "#{users.size} user(s) Identified.")
        else
          output('users', users: users)
        end
      end

      # @return [ Range ] The user ids range to enumerate
      # If the --enumerate is used, the default value is handled by the Option
      # However, when using --passwords alone, the default has to be set by the code below
      def enum_users_range
        ParsedCli.enumerate&.dig(:users) || cli_enum_choices[0].choices[:u].validate(nil)
      end
    end
  end
end
