module Quandl::Data::Logging
  
  extend ActiveSupport::Concern

  def to_h
    t1 = Time.now
    r = super
    Quandl::Logger.debug("#{self.class.name}.to_h (#{t1.elapsed_ms})")
    r
  end
  
  def to_csv
    t1 = Time.now
    r = super
    Quandl::Logger.debug("#{self.class.name}.to_csv (#{t1.elapsed_ms})")
    r
  end
  
end