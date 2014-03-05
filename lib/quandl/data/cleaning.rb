module Quandl
class Data
module Cleaning
  
  extend ActiveSupport::Concern
  
  protected
  
  def clean(data)
    # check if data is dirty
    requires_cleaning = ensure_data_requires_cleaning(data)
    # short ciruit unless data is dirty
    return requires_cleaning unless requires_cleaning == true
    # ensure we're dealing with an array
    data = ensure_data_is_an_array(data)
    # clean with either format or babelfish
    known_format?( data ) ? clean_with_format(data) : clean_with_babelfish(data)
  end
  
  def ensure_data_requires_cleaning(data)
    # skip cleaning if already clean
    return data if data.kind_of?(Array) && cleaned?
    # Quandl::Data is already clean, but to avoid errors extract internal array
    if data.kind_of?(Quandl::Data)
      # extract headers and errors if present
      @headers = data.headers
      @errors = data.errors
      return data.to_date.to_a
    end
    # Return empty array if given empty string, nil, etc.
    return [] if data.blank?
    # data requires cleaning
    true
  end
  
  def ensure_data_is_an_array(data)
    # Hash needs conversion to array
    data = Quandl::Data::Format.hash_to_array( data )
    # String needs conversion to array
    data = Quandl::Data::Format.csv_to_array( data )
    data
  end
  
  def known_format?( data )
    Format.recognized_date?( data[0][0] )
  end
  
  def clean_with_format(data)
    puts 'expensive'
    data = Format.parse( data )
    cleaned!
    data
  end
  
  def clean_with_babelfish(data)
    puts 'expensive'
    data, self.headers = Quandl::Babelfish.clean(data)
    cleaned!
    data
  end
  
  def cleaned!
    self.cleaned = true
  end
  
end
end
end