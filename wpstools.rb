#!/usr/bin/env ruby
# encoding: UTF-8

$: << '.'
require File.dirname(__FILE__) + '/lib/wpstools/wpstools_helper'

begin
  # delete old logfile, check if it is a symlink first.
  File.delete(LOG_FILE) if File.exist?(LOG_FILE) and !File.symlink?(LOG_FILE)

  banner()

  option_parser = CustomOptionParser.new('Usage: ./wpstools.rb [options]', 60)
  option_parser.separator ''
  option_parser.add(['-v', '--verbose', 'Verbose output'])

  plugins = Plugins.new(option_parser)
  plugins.register(
    CheckerPlugin.new,
    StatsPlugin.new,
    CheckerSpelling.new
  )

  options = option_parser.results

  if options.empty?
    raise "No option supplied\n\n#{option_parser}"
  end

  plugins.each do |plugin|
    plugin.run(options)
  end

  exit(0)
rescue => e
  puts "[ERROR] #{e.message}"

  unless e.backtrace[0] =~ /main/
    puts 'Trace :'
    puts e.backtrace.join("\n")
  end

  exit(1)
end
