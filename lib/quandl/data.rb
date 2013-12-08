require "quandl/data/version"

require "active_support"
require "active_support/inflector"
require "active_support/core_ext/hash"
require "active_support/core_ext/object"

require "quandl/operation"

require 'quandl/error/unknown_date_format'

require 'quandl/data/attributes'
require 'quandl/data/cleaning'
require 'quandl/data/enumerator'
require 'quandl/data/operations'
require 'quandl/data/format'
require 'quandl/data/logging'

module Quandl
class Data
  include Attributes
  include Cleaning
  include Enumerator
  include Operations
  include Logging if defined?(QUANDL_LOGGER) && QUANDL_LOGGER == true
end
end
