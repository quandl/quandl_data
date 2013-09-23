# encoding: utf-8
require 'spec_helper'

describe Quandl::Fabricate::Data::Table do
  
  let(:data){ Quandl::Fabricate::Data::Table.rand( rows: 4, columns: 5, nils: false ) }
  subject{ data }
  
  it{ should be_a Quandl::Data::Table }
  its(:count){ should eq 4 }
  
  describe "#first" do
    subject{ data.first }
    its(:count){ should eq 6 }
    
    its([0]){ should be_a Integer }
    
    [1,2,3,4,5].each do |i|
      its([i]){ should be_a Float }
    end
  end
  
end