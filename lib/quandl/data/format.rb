module Quandl
class Data
class Format

  class << self

    def parse(data)
      return [] if data.blank?
      data = hash_to_array(data)
      data = csv_to_array(data)
      data = values_to_float(data)
      data = to_date(data)
      data.dup
    end

    def hash_to_array(data)
      data = data.collect{|k,v| [k] + v } if data.kind_of?(Hash)
      data
    end

    def csv_to_array(data)
      if data.is_a?(String)
        data = data.gsub('\n', "\n")
        data = CSV.parse( data, col_sep: guess_csv_delimiter(data) )
      end
      data
    end

    def guess_csv_delimiter(data)
      data = data.to_s
      line_end = data.to_s.index("\n")
      first_line = line_end.nil? ? data : data[0..line_end].to_s
      return "\t" unless first_line.index("\t").nil?
      ","
    end

    def to_date(data)
      return data if data_missing_rows?(data)
      # guess the current date format
      format = date_format?(data)
      # convert dates to Date
      case format
      when :date            then return data
      when :date_string     then return date_strings_to_date( data )
      when :jd, :jd_string  then return jds_to_date( data )
      when :unknown         then raise_date_parse_error!( data[0] )
      end
      # return data
      data
    end

    def to_jd(data)
      return data if data_missing_rows?(data)
      # guess the current date format
      format = date_format?(data)
      # convert dates to Date
      case format
      when :jd          then return data
      when :jd_string   then return jd_strings_to_jd( data )
      when :date        then return dates_to_jd( data )
      when :date_string then return date_strings_to_jd( data )
      when :unknown     then raise_date_parse_error!( data[0] )
      end
      # return data
      data
    end

    def recognized_date?( value )
      return true if value.is_a?(Date)
      return true if value.is_a?(String) && value =~ /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$/
      false
    end

    def date_format?(data)
      value = data[0][0]
      # julian date?
      return :date          if value.is_a?(Date)
      return :jd            if value.is_a?(Integer)
      return :date_string   if value.is_a?(String) && value =~ /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$/
      return :jd_string     if value.kind_of?(String) && value.numeric?
      return :unknown
    end

    def dates_to_jd(data)
      return data if data_missing_rows?(data) || data[0][0].is_a?(Integer)
      # dont alter by reference
      result = []
      # for each row
      data.each_with_index do |row, index|
        # copy
        row = row.dup
        # string to date
        date = row[0]
        date = Date.parse(row[0]) if row[0].is_a?(String)
        # date to julian
        row[0] = date.jd if date.respond_to?(:jd)
        # save result
        result[index] = row
      end
      # all done
      result
    end


    ###################
    # DATES TO JULIAN #
    ###################

    def jd_strings_to_jd(data)
      # skip when already formatted correctly
      return data if data_missing_rows?(data) || data[0][0].is_a?(Integer)
      # otherwise cast string jds to int
      output = []
      data.each_with_index do |row, index|
        output << parse_jd_string(row, index)
      end
      output
    end

    def date_strings_to_jd(data)
      # skip when already formatted correctly
      return data if data_missing_rows?(data) || data[0][0].is_a?(Date)
      # otherwise cast string jds to int
      output = []
      data.each_with_index do |row, index|
        row = parse_date_string(row, index)
        row[0] = row[0].jd
        output << row
      end
      output
    end


    #################
    # DATES TO DATE #
    #################

    def jds_to_date(data)
      return data if data_missing_rows?(data) || data[0][0].is_a?(Date)
      output = []
      data.each_with_index do |row, index|
        output << parse_jd(row, index)
      end
      output
    end

    def date_strings_to_date(data)
      # skip when already formatted correctly
      return data if data_missing_rows?(data) || data[0][0].is_a?(Date)
      # otherwise cast string jds to int
      output = []
      data.each_with_index do |row, index|
        output << parse_date_string(row, index)
      end
      output
    end


    ###################
    # VALUES TO FLOAT #
    ###################

    def values_to_float(data)
      # skip unless value is a string
      return data if data_missing_rows?(data) || data[0][1].is_a?(Float)
      # cast values to float
      data.collect do |row|
        new_row = [row[0]]
        row[1..-1].each_with_index do |value, index|
          value = value.to_f if value.is_a?(String)
          new_row[index + 1] = value
        end
        new_row
      end
    end


    def data_missing_rows?(data)
      !data_has_rows?(data)
    end

    def data_has_rows?(data)
      data.is_a?(Array) && data[0].is_a?(Array) && data[0][0].present?
    end


    protected

    def parse_jd(row, index=nil)
      # parse jd_string
      row = parse_jd_string(row, index)
      # jd to date
      row[0] = Date.jd( row[0] )
      # onwards
      row
    rescue => e
      raise_jd_error!(row, index, e)
    end

    def parse_jd_string(row, index=nil)
      row = row.dup
      row[0] = row[0].to_i
      # dont allow dates that are before 0000
      raise if row[0] <= 1721058
      # onwards
      row
    rescue => e
      raise_jd_string_error!(row, index, e)
    end

    def parse_date_string(row, index=nil)
      row = row.dup
      # extract date
      date = row[0]
      # split date into parts
      date_values = date.split('-').collect(&:to_i)
      # ensure valid
      raise unless date_values.count == 3
      # add to row
      row[0] = Date.new( *date_values )
      row
    rescue => e
      raise_date_string_error!(row, index, e)
    end


    private

    def raise_jd_error!(row, index, err)
      raise Quandl::Error::DateParseError.new( line: index, context: 'parse_jd', row: row,  problem: err.message ), err.message
    end

    def raise_jd_string_error!(row, index, err)
      m = "Julian Date predates time. Expected <= 1721058 received '#{row[0]}'"
      raise Quandl::Error::DateParseError.new( line: index, context: 'parse_jd_string', row: row, problem: m ), m
    end

    def raise_date_string_error!(row, index, err)
      m = "Invalid date segments. Expected yyyy-mm-dd received '#{row[0]}'"
      raise Quandl::Error::DateParseError.new({ line: index, context: 'parse_date_string', row: row, problem: m }), m
    end

    def raise_date_parse_error!(row, index = 0, type = :none)
      m = "'#{row[0]}', index: data[#{index}][0] strategy: '#{type}', row: '#{row}'"
      raise Quandl::Error::DateParseError.new({ line: index, context: 'date_parse_error', row: row, problem: m }), m
    end

  end

end
end
end
