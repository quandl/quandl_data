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
    t1 = Time.now
    # skip cleaning if already clean
    return data if data.kind_of?(Array) && cleaned?
    # Quandl::Data is already clean, but to avoid errors extract internal array
    return data.data_array if data.kind_of?(Quandl::Data)
    # Quandl::Babelfish::Data is already clean
    return data if data.kind_of?(Quandl::Babelfish::Data)
    # Return empty array if given empty string, nil, etc.
    return [] if data.blank?
    # String needs conversion to array
    data = Format.csv_to_array( data ) if data.kind_of?(String)
    # Hash needs conversion to array
    data = Format.hash_to_array( data ) if data.kind_of?(Hash)
    # Array needs cleaning
    data = Quandl::Babelfish.clean( data )
    # mark data as clean
    cleaned!
    # return data
    data
  ensure
    puts "clean #{t1.elapsed_ms} #{data.count}" if t1.elapsed > 0.01
  end

  def cleaned!
    self.cleaned = true
  end
  
end
end
end