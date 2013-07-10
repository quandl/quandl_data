module Quandl
module Data
class Table
  
module Loggable
  
  extend ActiveSupport::Concern

  def to_h
    Quandl::Logger.info_with_elapsed("Quandl::Data::Table.to_h"){ super }
  end
  
  def to_csv
    Quandl::Logger.info_with_elapsed("Quandl::Data::Table.to_csv"){ super }
  end
  
end

end
end
end