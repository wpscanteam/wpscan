# encoding: UTF-8

class WpTimthumbs < WpItems
  module Detectable

    # No passive detection
    # @return [ WpTimthumbs ]
    def passive_detection(wp_target, topns = {})
      new
    end

    def targets_items(wp_target, options = {})
      unless options[:file]
        raise 'A file must be supplied'
      end

      targets = options[:theme_name] ? theme_timthumbs(options[:theme_name], wp_target) : []

      File.open(options[:file], 'r') do |f|
        f.readlines.collect do |path|
          targets << create_item(wp_target, path.strip)
        end
      end

      targets.uniq { |i| i.url }
    end

    # @return [ WpTimthumb Array ]
    def theme_timthumbs(theme_name, wp_target)
      targets     = []
      wp_timthumb = create_item(wp_target)

      %w{
        timthumb.php lib/timthumb.php inc/timthumb.php includes/timthumb.php
        scripts/timthumb.php tools/timthumb.php functions/timthumb.php
      }.each do |path|
        wp_timthumb.path = "$wp-content$/themes/#{theme_name}/#{path}"

        targets << wp_timthumb.dup
      end
      targets
    end

    # @return [ WpTimthumb ]
    def create_item(wp_target, path = nil)
      options = {
        wp_content_dir: wp_target.wp_content_dir,
        wp_plugins_dir: wp_target.wp_plugins_dir
      }

      options.merge!(path: path) if path

      WpTimthumb.new(wp_target.uri, options)
    end
  end
end
