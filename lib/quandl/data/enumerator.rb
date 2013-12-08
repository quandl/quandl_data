module Quandl::Data::Enumerator
  extend ActiveSupport::Concern
  
  included do
    delegate *Array.forwardable_methods, to: :data_array
  
    delegate :to_json, :as_json, to: :data_array
    
    attr_accessor :pristine_data
  end
  
  def data_array
    @data_array ||= clean( pristine_data )
  end

  def data_array=(data)
    @data_array = clean(data)
  end
  
  def data_array?
    @data_array.present?
  end

end