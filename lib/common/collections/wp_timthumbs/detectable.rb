# encoding: UTF-8

class WpTimthumbs < WpItems
  module Detectable

    # No passive detection
    #
    # @param [ WpTarget ] wp_target
    # @param [ Hash ] options
    #
    # @return [ WpTimthumbs ]
    def passive_detection(wp_target, options = {})
      new
    end

    protected

    # @param [ WpTarget ] wp_target
    # @param [ Hash ] options
    # @option options [ String ] :file The path to the file containing the targets
    # @option options [ String ] :theme_name
    #
    # @return [ Array<WpTimthumb> ]
    def targets_items(wp_target, options = {})
      targets = options[:theme_name] ? theme_timthumbs(options[:theme_name], wp_target) : []

      if options[:file]
        targets += targets_items_from_file(options[:file], wp_target)
      end

      targets.uniq { |i| i.url }
    end

    # @param [ String ] theme_name
    # @param [ WpTarget ] wp_target
    #
    # @return [ Array<WpTimthumb> ]
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

    # @param [ String ] file
    # @param [ WpTarget ] wp_target
    #
    # @return [ Array<WpTimthumb> ]
    def targets_items_from_file(file, wp_target)
      targets = []

      File.open(file, 'r') do |f|
        f.readlines.collect do |path|
          targets << create_item(wp_target, path.strip)
        end
      end
      targets
    end

    # @param [ WpTarget ] wp_target
    # @option [ String ] path
    #
    # @return [ WpTimthumb ]
    def create_item(wp_target, path = nil)
      options = {
        wp_content_dir: wp_target.wp_content_dir,
        wp_plugins_dir: wp_target.wp_plugins_dir,
        wp_local_dir: wp_target.wp_local_dir
      }

      options.merge!(path: path) if path

      WpTimthumb.new(wp_target.uri, options)
    end
  end
end
