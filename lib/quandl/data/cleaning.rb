module Quandl
class Data
module Cleaning
  
  extend ActiveSupport::Concern
  
  def cleaned
    @cleaned
  end
  def cleaned=(value)
    @cleaned = (value == true)
  end
  def cleaned?
    cleaned == true
  end

  protected
  
  def clean(data)
    # skip cleaning if already clean
    return data if data.kind_of?(Array) && cleaned?
    # Quandl::Data is already clean, but to avoid errors extract internal array
    return data.data_array if data.kind_of?(Quandl::Data)
    # Return empty array if given empty string, nil, etc.
    return [] if data.blank?
    # String needs conversion to array
    data = Format.parse( data )
    # mark data as clean
    cleaned!
    # return data
    data
  end

  def cleaned!
    self.cleaned = true
  end
  
end
end
end