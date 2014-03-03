module Quandl
class Data
module Validations
  
  ERROR_TYPES = [ 
    Error::GuessDateFormat,   Error::InvalidDate,
    Error::UnknownDateFormat, Error::DateParseError,
    CSV::MalformedCSVError ]
    
  extend ActiveSupport::Concern

  module ClassMethods
    
  end
  
  included do
    validate :data_should_be_clean!
  end
  
  def data_should_be_clean!
    @data_array = clean(pristine_data)
    true
    
  rescue *ERROR_TYPES => err
    self.errors.add( :data, err.to_s )
    @data_array = []
    false
    
  end
  
end
end
end