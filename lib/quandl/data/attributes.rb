module Quandl
class Data
module Attributes
  
  extend ActiveSupport::Concern
  
  included do
    
    include Quandl::Support::Attributes
    
    define_attributes :headers, :pristine_data, :cleaned, :data_array
    
    delegate *Array.forwardable_methods, to: :data_array
    delegate :to_json, :as_json, to: :data_array

    def headers=(value)
      write_attribute(:headers, Array(value).flatten )
    end
    
  end
  
  def initialize(*args)
    # passed an instance of quandl data?
    if args.first.kind_of?(Quandl::Data)
      @attributes = args.first.attributes
    elsif args.first.present?
      self.pristine_data = args.first
    end
    valid? unless cleaned?
  end
  
end
end
end