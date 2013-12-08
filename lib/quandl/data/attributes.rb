module Quandl
class Data
module Attributes
  
  extend ActiveSupport::Concern
  
  module ClassMethods
    
    def with_type(type)
      type = type.to_s.downcase.to_sym
      case type
      when :dirty, :babelfish then Quandl::Babelfish::Data
      else 
        Quandl::Data 
      end
    end
    
  end
  
  def initialize(*args)
    self.pristine_data = args.first
    self.attributes = args.extract_options!
  end
  
  def headers=(value)
    # only assign arrays
    @headers = value.flatten if value.kind_of?(Array)
  end
  def headers
    @headers
  end
  def headers?
    headers.present?
  end
  
  def attributes
    @attributes ||= {}
  end
  def attributes=(attrs)
    assign_attributes(attrs)
    attributes
  end
  def assign_attributes(attrs)
    attrs.each do |name, value|
      self.send("#{name}=", value) if self.respond_to?("#{name}=")
    end
  end
  
end
end
end