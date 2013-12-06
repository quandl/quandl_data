require "quandl/data/version"

require "active_support"
require "active_support/inflector"
require "active_support/core_ext/hash"
require "active_support/core_ext/object"

require "quandl/operation"
require "quandl/babelfish"

require 'quandl/errors/unknown_date_format'

require 'quandl/data/babelfisher'
require 'quandl/data/enumerator'
require 'quandl/data/operations'
require 'quandl/data/format'
require 'quandl/data/logging'

module Quandl
class Data
  include Babelfisher
  include Enumerator
  include Operations
  include Logging if defined?(QUANDL_LOGGER) && QUANDL_LOGGER == true
end
end
