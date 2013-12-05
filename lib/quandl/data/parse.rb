module Quandl
class Data
class Parse
  
  class << self
    
    def data(blob)
      # our output
      output = []
      # convert the blob to and array
      data = csv_to_array(blob)
      # convert each row
      data.each do |row|
        result = []
        # parse the date
        result[0] = Quandl::Data::Date.parse( row[0] )
        # parse each value
        row[1..-1].each_with_index do |value, index|
          # parse each value
          result[ index + 1 ] = Quandl::Data::Value.parse( value )
        end
        output << result
      end
      # return the parsed data
      output
    end
    
    def csv_to_array(data)
      if data.is_a?(String)
        data = data.gsub('\n', "\n")
        data = CSV.parse( data )
      end
      data
    end
    
  end
  
end
end
end