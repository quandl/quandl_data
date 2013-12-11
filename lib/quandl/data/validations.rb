module Quandl
class Data
module Validations
  
  extend ActiveSupport::Concern

  module ClassMethods
    
  end
  
  included do
    ERROR_TYPES = [ 
      Error::GuessDateFormat,   Error::InvalidDate,
      Error::UnknownDateFormat, Error::DateParseError ]
  end
  
  def valid?
    raise_error_unless_valid!
  rescue *ERROR_TYPES => error
    self.errors << error
    self.data_array = []
    false
  end
  
  def raise_error_unless_valid!
    self.errors = []
    self.data_array = pristine_data
    true
  end
  
  def errors
    @errors ||= []
  end
  def errors=(value)
    @errors = value
  end

end
end
end