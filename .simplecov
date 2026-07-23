# frozen_string_literal: true

if ENV['GITHUB_ACTION']
  require 'simplecov-lcov'

  SimpleCov::Formatter::LcovFormatter.config do |c|
    c.single_report_path = 'coverage/lcov.info'
    c.report_with_single_file = true
  end

  SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
end

SimpleCov.configure do
  enable_coverage :branch # Only supported for Ruby >= 2.5

  skip '/spec/'
  skip 'helper'
end
