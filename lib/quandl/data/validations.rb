module Quandl
class Data
module Validations
  
  extend ActiveSupport::Concern

  module ClassMethods
    
  end
  
  included do
    ERROR_TYPES = [ 
      Error::GuessDateFormat, Error::InvalidDate,
      Error::UnknownDateFormat, Error::DateParseError ]
  end
  
  def valid?
    self.errors = []
    self.data_array = pristine_data
    true
  rescue *ERROR_TYPES => error
    self.errors << error
    self.data_array = []
    false
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