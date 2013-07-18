module Quandl
module Data
class Table
  
module Operations
  
  extend ActiveSupport::Concern
  include Quandl::Operation

  module ClassMethods
    
    def forwardable_methods
      @forwardable_methods ||= (operations + operations.collect{|o| "#{o}!" if method_defined?("#{o}!") }).compact
    end
    
    def operations
      [
        :to_csv, :to_jd, :to_date, :sort_order, :sort_ascending, 
        :sort_descending, :transform, :collapse, :frequency, :parse
      ]
    end
    
  end

  def to_h
    data_array.inject({}) do |memo, row|
      memo[row[0]] = row[1..-1]
      memo
    end
  end
  
  def to_csv
    return data_array.collect(&:to_csv).join if data_array?
    return pristine_data.collect(&:to_csv).join if pristine_data.kind_of?(Array)
    return pristine_data if pristine_data.kind_of?(String)
    return ''
  end
  
  def to_jd
    Table.new( Parse.date_to_julian( data_array ), frequency: frequency )
  end
  def to_jd!
    @data_array = Parse.date_to_julian( data_array )
    self
  end
  
  def to_date
    Parse.julian_to_date data_array
  end
  def to_date!
    @data_array = Parse.julian_to_date data_array
    self
  end
  
  def limit(amount)
    @data_array = data_array[0..( amount.to_i - 1 )] if amount.present?
    self
  end
  
  def sort_order(dir)
    dir == :asc ? sort_ascending! : sort_descending!
  end
  
  def sort_ascending
    Table.new( Parse.sort( data_array, :asc ), frequency: frequency )
  end
  def sort_ascending!
    @data_array = Parse.sort( data_array, :asc )
    self
  end
  
  def sort_descending
    Table.new( Parse.sort( data_array, :desc ), frequency: frequency )
  end
  def sort_descending!
    @data_array = Parse.sort( data_array, :desc )
    self
  end
  
  def transform(*args)
    return @transform unless args.first.present?
    self.transform = args.first
    self
  end
  def transform=(value)
    @transform = value
    @data_array = Transform.perform( data_array, value )
  end

  def collapse(*args)
    return @collapse unless args.first.present?
    self.collapse = args.first
    self
  end
  def collapse=(collapse)
    @collapse = collapse
    @frequency = collapse
    @data_array = Collapse.perform( data_array, collapse )
  end
  
  def frequency
    @frequency ||= Collapse.frequency?( data_array )
  end
  def frequency=(value)
    @frequency = value.to_sym
  end
  
  def parse(data)
    data = Parse.perform( data )
    data
  end
  
end

end
end
end