module Quandl::Data::Enumerator
  extend ActiveSupport::Concern
  
  included do
    delegate *Array.forwardable_methods, to: :data_array
  
    delegate :to_json, :as_json, to: :data_array
    
    attr_accessor :pristine_data
  end
  
  protected
  
  def data_array
    valid? unless data_array?
    @data_array
  end

  def data_array?
    defined?(@data_array)
  end

end