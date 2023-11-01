require 'active_model'
require "active_support/concern"

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

  def initialize(args = nil)
    run_callbacks(:initialize) do
      # apply _attributes directly to @attributes
      @attributes = args.is_a?(Hash) ? args.delete(:_attributes) : {}
      # apply attrs through write_attribute
      self.attributes = args if args.is_a?(Hash)
      # onwards
      super(args) if defined?(super)
    end
  end

  def attributes=(new_attrs)
    new_attrs.stringify_keys.each do |attr_key, attr_value|
      # skip those attributes that are not defined
      next unless self.class.attributes.include?(attr_key) && self.respond_to?("#{attr_key}=")
      # pass to the attribute writer
      self.send( "#{attr_key}=", attr_value )
    end
  end

  def attributes
    @attributes ||= {}
  end

  protected

  def read_attribute(key)
    @attributes[key.to_s]
  end

  def write_attribute(key, value)
    @attributes ||= {}
    @attributes[key.to_s] = value
  end

end
end
end
