module Quandl
class Data
module Babelfisher
  
  extend ActiveSupport::Concern
  
  def headers=(value)
    @headers = value
  end
  def headers
    @headers ||= data_array.respond_to?(:headers) ? data_array.headers : nil
  end
  def headers?
    headers.present?
  end

  protected
  
  def clean(data)
    # Quandl::Data is already clean, but to avoid errors extract internal array
    return data.data_array if data.is_a?(Quandl::Data)
    # Quandl::Babelfish::Data is already clean
    return data if data.is_a?(Quandl::Babelfish::Data)
    # otherwise parse and clean
    data = CSV.parse( data ) if data.is_a?(String)
    data = Quandl::Babelfish.clean( data )
    data
  end
  
end
end
end