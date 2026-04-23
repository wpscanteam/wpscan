# frozen_string_literal: true

module WPScan
  module Model
    # User
    class User
      include Finders::Finding

      attr_accessor :password
      attr_reader :id, :username

      # @param [ String ] username
      # @param [ Hash ] opts
      # @option opts [ Integer ] :id
      # @option opts [ String ] :password
      def initialize(username, opts = {})
        @username = username
        @password = opts[:password]
        @id       = opts[:id]

        parse_finding_options(opts)
      end

      def ==(other)
        return false unless self.class == other.class

        username == other.username && password == other.password
      end

      def to_s
        username
      end
    end
  end
end
