module Quandl::Data::Enumerator
  extend ActiveSupport::Concern
  
  included do
    
    delegate *Array.forwardable_methods, to: :data_array
  
    delegate :to_json, :as_json, to: :data_array
  
    attr_accessor :pristine_data
  end
  
  def initialize(*args)
    self.pristine_data = args.first
    self.attributes = args.extract_options!
  end
  
  def data_array
    @data_array ||= parse( pristine_data )
  end

  def data_array=(data)
    @data_array = parse(data)
  end
  
  def data_array?
    @data_array.present?
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