module Quandl
class Data
class Value
  class << self
    
    def parse(value)
      # replace this with your own value parsing code
      Float(value)
    end
    
  end
end
end
end