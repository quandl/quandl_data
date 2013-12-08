module Quandl
class Data
module Attributes
  
  extend ActiveSupport::Concern
  
  def initialize(*args)
    self.pristine_data = args.first
    self.attributes = args.extract_options!
  end
  
  def headers=(value)
    # reject headers unless array
    return unless value.kind_of?(Array)
    # assign
    @headers = value.flatten
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