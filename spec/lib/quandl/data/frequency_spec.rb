# encoding: utf-8
require 'spec_helper'

describe Quandl::Data do
  
  let(:table){ [] }
  let(:data){ Quandl::Data.new(table) }
  subject{ data }
  
  its(:frequency){ should eq nil }
  
  describe "#frequency" do
    
    subject{ data.frequency }
    
    {
      daily:      [['2012-01-01','1','2'],['2012-01-02','3','4'],['2012-01-03','5','6']],
      monthly:    [['2012-01-01','1','2'],['2012-02-01','3','4'],['2012-04-01','5','6'],['2012-04-01','1','2'],['2012-05-01','3','4'],['2012-06-01','5','6']],
      quarterly:  [['2012-01-01','1','2'],['2012-04-01','3','4'],['2012-07-01','5','6'],['2012-10-01','1','2'],['2013-01-01','3','4'],['2012-04-01','5','6']],
      annual:     [['2008-01-01','1','2'],['2008-12-01','3','4'],['2010-01-01','5','6'],['2011-01-01','1','2'],['2013-01-01','5','6']],
      
    }.each do |freq, data|
      context "given daily #{freq}" do
        let(:table){ data }
        it{ should eq freq }
      end
    end
    
    context "given one row" do
      let(:table){ [['2010-01-01','1','2']] }
      it{ should eq :daily }
    end
    
    context "given nil" do
      let(:table){ nil }
      it{ should eq nil }
    end
    
  end

end