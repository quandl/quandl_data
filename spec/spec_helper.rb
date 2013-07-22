$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "rspec"
require "csv"
require "quandl/data"