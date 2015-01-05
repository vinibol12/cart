# Set up gems listed in the Gemfile.old.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile.old', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
