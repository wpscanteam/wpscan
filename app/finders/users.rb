# frozen_string_literal: true

require_relative 'users/author_posts'
require_relative 'users/wp_json_api'
require_relative 'users/oembed_api'
require_relative 'users/rss_generator'
require_relative 'users/author_id_brute_forcing'
require_relative 'users/login_error_messages'
require_relative 'users/yoast_seo_author_sitemap.rb'

module WPScan
  module Finders
    module Users
      # Users Finder
      class Base
        include CMSScanner::Finders::SameTypeFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders <<
            Users::AuthorPosts.new(target) <<
            Users::WpJsonApi.new(target) <<
            Users::OembedApi.new(target) <<
            Users::RSSGenerator.new(target) <<
            Users::YoastSeoAuthorSitemap.new(target) <<
            Users::AuthorIdBruteForcing.new(target) <<
            Users::LoginErrorMessages.new(target)
        end
      end
    end
  end
end
