# encoding: utf-8
require 'spec_helper'

describe Quandl::Data::Table do
  subject { Quandl::Data::Random.table( nils: false, rows: 4, columns: 4 ) }
  
  its(:to_csv){ should be_a String }
  its(:to_h){ should be_a Hash }
  its(:count){ should eq 4 }
  
  it "should parse csv" do
    Quandl::Data::Table.new(subject.to_csv).count.should eq 4
  end
  
  it "should transform the data" do
    value = subject.first[1]
    subject.transform(:rdiff).first[1].should_not eq value
  end
  
  it "should collapse the data" do
    subject.collapse(:monthly).count.should eq 1
  end
  
  it "should convert julian dates to dates" do
    subject.to_date.first.first.should be_a Date
  end
  
end