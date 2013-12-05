module Quandl
class Data
class Date
  class << self
    
    def parse(value)
      # replace this with your own date parsing code
      ::Date.parse(value)
    end
    
  end
end
end
end