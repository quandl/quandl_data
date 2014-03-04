module Quandl
class Data
module Attributes
  
  extend ActiveSupport::Concern
  
  def initialize(*args)
    self.pristine_data = args.first
    self.attributes = args.extract_options!
  end

  def headers?
    headers.present?
  end
  def headers=(value)
    @headers = value.flatten if value.kind_of?(Array)
  end
  def headers
    ensure_data_is_cleaned
    @headers
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