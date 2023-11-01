module Quandl
class Data
module Attributes

  extend ActiveSupport::Concern

  included do

    include Quandl::Support::Attributes

    define_attributes :headers, :pristine_data, :cleaned, :data_array

    delegate *Array.forwardable_methods, to: :data_array

    def headers=(value)
      write_attribute(:headers, Array(value).flatten )
    end

    def cleaned?
      read_attribute(:cleaned) == true
    end

  end

  def initialize(args = nil)
    # passed an instance of quandl data?
    if args.kind_of?(Quandl::Data)
      @attributes = args.attributes
    elsif args.present?
      self.pristine_data = args
    end
    valid? unless cleaned?
  end

  def to_json
    ensure_json_support
    data_array.try(:to_json)
  end

  def as_json
    ensure_json_support
    data_array.try(:as_json)
  end

  private

  def ensure_json_support
    require 'active_support/core_ext/object' unless Object.respond_to?(:as_json)
  end

end
end
end
