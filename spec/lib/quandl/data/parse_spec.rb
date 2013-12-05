# encoding: utf-8
require 'spec_helper'

describe Quandl::Data::Parse do
  
  expectations = [
    { 
      input:  "2013-12-05,10.03,11.0271,13.96623,19.1262\n2013-12-04,10.0760,11.0745,13.9777,19.2117",
      output: [[ Date.parse('2013-12-05'), 10.03, 11.0271, 13.96623, 19.1262 ], [ Date.parse('2013-12-04'), 10.0760, 11.0745, 13.9777, 19.2117 ]]
    },
  ]
  
  describe ".data" do
    expectations.each do |data|
      it "should recieve:\n#{data[:input].gsub(%Q{\n},'\n')} \n    and return:\n#{data[:output]}" do
        Quandl::Data::Parse.data(data[:input]).should eq data[:output]
      end
    end
  end
end
