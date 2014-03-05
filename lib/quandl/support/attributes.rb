require 'active_model'
require "active_support/all"

module Quandl
module Support
module Attributes
  
  extend ActiveSupport::Concern
  
  included do
    extend ActiveModel::Callbacks
    define_model_callbacks :initialize, only: [:after]
  end
  
  module ClassMethods
    
    def inherited(subclass)
      subclass.define_attributes(*attributes)
      subclass.formatters = formatters.dup
    end
    
    def define_attributes(*attribute_names)
      attribute_names.each do |key|
        define_attribute(key)
      end
    end

    def attributes
      @attributes ||= []
    end

    protected

    def define_attribute(key)
      key = key.to_s
      attributes << key unless attributes.include?(key)
      define_method( key ){ read_attribute(key) }
      define_method( "#{key}=" ){ |value| write_attribute(key, value) }
      define_method( "#{key}?" ){ !read_attribute(key).nil? }
    end
    
  end
  
  def initialize(*args)
    run_callbacks(:initialize) do
      attrs = args.extract_options!
      # apply _attributes directly to @attributes
      @attributes = attrs[:_attributes].is_a?(Hash) ? attrs.delete(:_attributes) : {}
      # apply attrs through write_attribute
      self.attributes = attrs
      # onwards
      super(*args) if defined?(super)
    end
  end
  
  def attributes=(new_attributes)
    # for each defined attribute
    self.class.attributes.each do |attribute_name|
      # if new_attriubtes is present and the object responds to this method
      if new_attributes.has_key?(new_attributes) && self.respond_to?("#{attribute_name}=")
        # assign the change
        self.send( "#{key}=", new_attributes[attribute_name] )
      end 
    end
    
  end
  
  def attributes
    self.class.attributes.inject({}){|m,k| m[k] = self.send(k); m }
  end
  
  protected
  
  def read_attribute(key)
    @attributes[key.to_s]
  end
  
  def write_attribute(key, value)
    @attributes[key.to_s] = value
  end
  
end
end
end