require 'simplecov'
SimpleCov.start

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "rspec"
require "csv"
require "json"
require 'quandl/fabricate'
require "quandl/data"