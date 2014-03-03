module Quandl
class Data
module Operations
  
  extend ActiveSupport::Concern

  module ClassMethods
    
    def new_with_jd(*args)
      # force data to date
      args[0] = Format.to_date( args[0] )
      # onwards
      self.new( *args )
    end
    
    def forwardable_methods
      @forwardable_methods ||= (operations + operations.collect{|o| "#{o}!" if method_defined?("#{o}!") }).compact
    end
    
    def operations
      [ :to_csv, :to_jd, :to_date, :sort_order, :sort_ascending, 
        :sort_descending, :transform, :collapse, :frequency, :parse ]
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
    return pristine_data.collect(&:to_csv).join if pristine_data.respond_to?(:collect)
    return pristine_data if pristine_data.kind_of?(String)
    return ''
  end
  
  def to_table
    self
  end
  
  def to_jd!
    @data_array = Quandl::Data::Format.to_jd( data_array ); self
  end
  
  def to_date!
    @data_array = Quandl::Data::Format.to_date( data_array ); self
  end
  
  def to_date_str!
    @data_array = to_date!.collect{|r| r = r.dup; r[0] = r[0].to_s; r }; self
  end
  
  def trim_start!(date)
    # date format
    date = Quandl::Operation::QDate.parse(date)
    # reject rows with dates less than
    @data_array = to_date!.sort_descending!.delete_if do |row|
      row_date = row[0]
      row_date < date
    end
    self
  end
  
  def trim_end!(date)
    # date format
    date = Quandl::Operation::QDate.parse(date)
    # reject rows with dates less than
    @data_array = to_date!.sort_descending!.delete_if do |row|
      row_date = row[0]
      row_date > date
    end
    self
  end
  
  def limit!(amount)
    @data_array = data_array[0..( amount.to_i - 1 )]; self
  end
  
  def sort_order(dir)
    dir == :asc ? sort_ascending! : sort_descending!
  end
  
  def sort_ascending!
    @data_array = Quandl::Operation::Sort.asc( data_array ); self
  end

  def sort_descending!
    @data_array = Quandl::Operation::Sort.desc( data_array ); self
  end
  
  def to_precision!(value)
    @data_array = Quandl::Operation::Value.precision(data_array, value); self
  end
  
  def row(*args)
    return @row if args[0].nil?
    @row = args[0]
    @data_array = [data_array[ args[0] ]]
    self
  end
  
  def transform(*args)
    return @transform unless args.first.present?
    self.transform = args.first
    self
  end
  def transform=(value)
    return false unless Quandl::Operation::Transform.valid?(value)
    @transform = value
    @data_array = Quandl::Operation::Transform.perform( data_array, value )
    @data_array
  end

  def collapse(*args)
    return @collapse unless args.first.present?
    self.collapse = args.first
    self
  end
  def collapse=(collapse)
    return false unless Quandl::Operation::Collapse.valid?(collapse)
    @collapse = collapse
    @frequency = collapse
    @data_array = Quandl::Operation::Collapse.perform( data_array, collapse )
  end
  
  def frequency
    @frequency ||= Quandl::Babelfish.guess_frequency( data_array ).try(:to_sym)
  end
  def frequency=(value)
    @frequency = value.to_sym if value.present?
  end
  
  def clone
    self.class.new( data_array.dup, headers: headers, cleaned: cleaned )
  end
  
  def to_precision(value)
    clone.to_precision!(value)
  end
  def to_jd
    clone.to_jd!
  end
  def to_date
    clone.to_date!
  end
  def to_date_str
    clone.to_date_str!
  end
  def trim_start(date)
    clone.trim_start!(date)
  end
  def trim_end(date)
    clone.trim_end!(date)
  end
  def limit(amount)
    clone.limit!(amount)
  end
  def sort_ascending
    clone.sort_ascending!
  end
  def sort_descending
    clone.sort_descending!
  end
  
end
end
end