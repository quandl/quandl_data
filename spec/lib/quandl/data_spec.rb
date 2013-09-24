# encoding: utf-8
require 'spec_helper'

describe Quandl::Data::Table do
  subject { Quandl::Fabricate::Data::Table.rand( nils: false, rows: 4, columns: 4 ) }

  its(:to_h){ should be_a Hash }
  its(:count){ should eq 4 }

  it "should parse csv" do
    Quandl::Data::Table.new(subject.to_csv).count.should eq 4
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

  describe "#transform" do
    it "should rdiff" do
      value = subject.first[1]
      subject.transform(:rdiff).first[1].should_not eq value
    end
    it "should rdiff_from" do
      data = Quandl::Data::Table.new([[1,3,5],[4,5,4],[5,15,20]])
      data.transform(:rdiff_from).should eq [[1,4,3],[4,2,4],[5,0,0]]
    end
    it "should cumul" do
      data = Quandl::Data::Table.new([ [1000, 10], [1001, 20], [1002, 30] ])
      data.transform(:cumul).should eq [[ [1000, 10], [1001, 30], [1002, 60] ]]
    end
  end

  it "should collapse the data" do
    subject.collapse(:monthly).count.should eq 1
  end

  it "should limit the data" do
    subject.limit(2).count.should eq 2
  end
  
  describe "to_csv" do
    
    its(:to_csv){ should be_a String }
    
    it "should output csv that is consistent with subject" do
      data = CSV.parse( subject.to_csv ).collect{|r| r.collect{|v| v.to_f } }
      data.should eq subject
    end
  
    it "should output csv when initialized with a Data::Table" do
      Quandl::Data::Table.new( subject ).to_csv.should eq subject.to_csv
    end
    
  end
  
  describe "to_date" do

    it "should convert julian dates to dates" do
      subject.to_date.first.first.should be_a Date
    end
    
  end
  
  describe "to_json" do
    it "should convert the data_array to json and back" do
      JSON.parse(subject.to_json).should eq JSON.parse(subject.data_array.to_json)
    end
  end
  
  describe "as_json" do
    it "should be a representation of data_array" do
      subject.as_json.should eq subject.data_array
    end
  end
  
  describe "trim_end" do
  
    it "should delete everything after trim_end" do
      data = Quandl::Fabricate::Data::Table.rand( nils: false, rows: 10, columns: 1 ).sort_descending
      date = data[1][0]
      data.trim_end!(date)
      data.data_array.should be_a Array
      data.count.should eq 9
    end
  
    it "should be chainable" do
      subject.trim_end(subject.first.first).trim_end(subject.last.first)
    end
    
    it "should not alter the original object" do
      data = subject.trim_end(subject[2][0])
      subject.count.should eq 4
    end
    
    it "should alter the original object" do
      subject.trim_end!(subject[2][0])
      subject.count.should eq 2
    end
  
  end
  
  describe "trim_start" do
  
    it "should delete everything before trim_start" do
      data = Quandl::Fabricate::Data::Table.rand( nils: false, rows: 10, columns: 1 ).sort_descending
      date = data[-2][0]
      data.trim_start(date).count.should eq 9
    end
  
    it "should be chainable" do
      subject.trim_start(subject.first.first).trim_end(subject.last.first)
    end
    
    it "should not alter the original object" do
      data = subject.trim_start(subject[2][0])
      subject.count.should eq 4
    end
    
    it "should alter the original object" do
      subject.trim_start!(subject[-3][0])
      subject.count.should eq 2
    end
  
  end
  
end