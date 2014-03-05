require "quandl/data/version"

require 'quandl/support'

require "quandl/operation"
require 'quandl/babelfish'
require 'quandl/error/date_parse_error'

require 'quandl/data/attributes'
require 'quandl/data/cleaning'
require 'quandl/data/operations'
require 'quandl/data/format'
require 'quandl/data/validations'
require 'quandl/data/logging'

module Quandl
class Data
  include Attributes
  include Cleaning
  include Operations
  include Validations
  include Logging if defined?(QUANDL_LOGGER) && QUANDL_LOGGER == true
end
end
