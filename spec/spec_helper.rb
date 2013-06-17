$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "rspec"
require "scope_builder"