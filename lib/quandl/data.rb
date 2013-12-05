require "quandl/data/version"

require "active_support"
require "active_support/inflector"
require "active_support/core_ext/hash"
require "active_support/core_ext/object"

require "quandl/operation"

require 'quandl/data/enumerator'
require 'quandl/data/operations'
require 'quandl/data/logging'

require 'quandl/data/date'
require 'quandl/data/value'
require 'quandl/data/parse'

class Quandl::Data
  include Enumerator
  include Operations
  include Logging if defined?(QUANDL_LOGGER) && QUANDL_LOGGER == true
end