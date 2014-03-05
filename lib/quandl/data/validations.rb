module Quandl
class Data
module Validations
  
  ERROR_TYPES = [ 
    Error::GuessDateFormat,   Error::InvalidDate,
    Error::UnknownDateFormat, Error::DateParseError,
    CSV::MalformedCSVError ]
    
  extend ActiveSupport::Concern
  
  included do
  
    include ActiveModel::Validations
  
    validate :data_should_be_clean!
  end
  
  def data_should_be_clean!
    self.data_array = clean(pristine_data)
    true
    
  rescue *ERROR_TYPES => err
    self.errors.add( :data, err.to_s )
    self.data_array = []
    false
    
  end
  
end
end
end