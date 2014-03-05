module Quandl
class Data
  VERSION = File.read(File.expand_path(File.join(File.dirname(__FILE__), '../../../VERSION'))).strip.rstrip
end
end