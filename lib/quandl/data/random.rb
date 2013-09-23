require 'quandl/data/table/operations'

module Quandl
module Data

  class Random

    def self.table(*args)
      warn "[DEPRECATION] `Quandl::Data::Random.table` is deprecated.  Please use `Quandl::Fabricate::Data::Table` instead."
      Quandl::Fabricate::Data::Table.rand(*args)
    end

  end

end
end