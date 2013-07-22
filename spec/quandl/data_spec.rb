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
  
  it "should output csv that is consistent with subject" do
    data = CSV.parse( subject.to_csv ).collect{|r| r.collect{|v| v.to_f } }
    data.should eq subject
  end
  
  it "should convert to julian dates" do
    data = subject.to_jd
    data[0][0].should be_a Integer
  end
  
  it "should convert to dates" do
    julian_data = subject.to_jd
    julian_data.first.first.should be_a Integer
    date_data = julian_data.to_date
    date_data.first.first.should be_a Date
  end
  
  it "should transform the data" do
    value = subject.first[1]
    subject.transform(:rdiff).first[1].should_not eq value
  end
  
  it "should transform the data to rdiff from" do
    data = Quandl::Data::Table.new([[1,3,5],[4,5,4],[5,15,20]])
    data.transform(:rdiff_from).should eq [[1,4,3],[4,2,4],[5,0,0]]
  end
  
  it "should collapse the data" do
    subject.collapse(:monthly).count.should eq 1
  end
  
  it "should limit the data" do
    subject.limit(2).count.should eq 2
  end
  
  it "should convert julian dates to dates" do
    subject.to_date.first.first.should be_a Date
  end
  
  it "should delete everything before trim_start" do
    data = Quandl::Data::Random.table( nils: false, rows: 10, columns: 1 ).sort_descending
    date = data[-2][0]
    data.trim_start(date).count.should eq 9
  end
  
  it "should delete everything after trim_end" do
    data = Quandl::Data::Random.table( nils: false, rows: 10, columns: 1 ).sort_descending
    date = data[1][0]
    data.trim_end!(date)
    data.data_array.should be_a Array
    data.count.should eq 9
  end
  
end