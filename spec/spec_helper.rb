require 'bacon'

require 'simplecov'
SimpleCov.start

require 'kot'

KOT_PROBABILISTIC_TESTS = !ENV['KOT_PROBABILISTIC_TESTS'].nil?
