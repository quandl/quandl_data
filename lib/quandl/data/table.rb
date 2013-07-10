require 'quandl/data/table/operations'

module Quandl
module Data
  
class Table

  include Operations
  include Loggable
  
  delegate *Array.forwardable_methods, to: :data_array

  def initialize(*args)
    data = args.first
    self.attributes = args.extract_options!
    self.data_array = data
  end

  def data_array
    @data_array ||= []
  end

  def data_array=(data)
    @data_array = parse(data)
  end

  def attributes
    @attributes ||= {}
  end

  def attributes=(attrs)
    assign_attributes(attrs)
    attributes
  end

  # mass assignment protection
  def assign_attributes(attrs)
    attrs.each do |name, value|
      self.send("#{name}=", value) if self.respond_to?("#{name}=")
    end
  end
  
end  
end
end
