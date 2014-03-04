module Quandl
module Support
module Attributes
  
  extend ActiveSupport::Concern
  
  included do
    
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
    end
    
  end
  
  def initialize(*args)
    attrs = args.extract_options!
    # apply _attributes directly to @attributes
    @attributes = attrs[:_attributes].is_a?(Hash) ? attrs.delete(:_attributes) : {}
    # apply attrs through write_attribute
    self.attributes = attrs
    # onwards
    super if defined?(super)
  end
  
  def attributes=(attrs)
    attrs.each do |key, value|
      self.send("#{key}=", value) if self.respond_to?("#{key}=")
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

class Test
  include Quandl::Support::Attributes
  define_attributes :name
end