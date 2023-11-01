# encoding: utf-8
require 'spec_helper'

describe Quandl::Data::Operations do

  let(:data){
    Quandl::Data.new([
      ["2014-01-31", 10.011073010381, 11.024243847751, 14.113783910035, 19.017842117647],
      ["2014-01-30", 9.9992952774272, 11.112437798533, 14.025780316243, 18.990993399363],
      ["2014-01-29", 9.9975306959077, 11.052299899858, 14.022480132639, 19.034560972456],
      ["2014-01-28", 9.9729411764706, 11.075058823529, 14.020588235294, 19.038]],  )
  }
  subject { data }

  its(:to_h){ should be_a Hash }
  its(:count){ should eq 4 }

  it "should parse csv" do
    Quandl::Data.new(subject.to_csv).count.should eq 4
  end

  it "should limit the data" do
    subject.limit(2).count.should eq 2
  end

  describe "#to_precision" do
    it "should set the precision" do
      raw = '1998,10.293842930288591859035,1200.293842930288591859035'
      Quandl::Data.new(raw).to_precision(6).to_date_str.should eq [["1998-12-31", 10.2938, 1200.29]]
    end
  end

  describe "#collapse=" do

    it "should collapse to monthly" do
      subject.collapse(:monthly).count.should eq 1
    end

    it "should reject invalid collapse" do
      subject.collapse(:invalid)
      subject.collapse.should_not eq :invalid
    end

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

    it "should reject invalid transform" do
      subject.transform(:invalid)
      subject.transform.should_not eq :invalid
    end

    it "should rdiff" do
      value = subject.first[1]
      subject.transform(:rdiff).first[1].should_not eq value
    end
    it "should rdiff_from" do
      data = Quandl::Data.new [["2013-11-27", 3.0, 5.0], ["2013-11-28", 5.0, 4.0], ["2013-11-29", 15.0, 20.0]]
      data.transform(:rdiff_from).to_date_str.should eq [["2013-11-27", 4.0, 3.0], ["2013-11-28", 2.0, 4.0], ["2013-11-29", 0.0, 0.0]]
    end
    it "should cumul" do
      data = Quandl::Data.new [["2013-11-27", 10.0], ["2013-11-28", 20.0], ["2013-11-29", 30.0]]
      data.transform(:cumul).to_date_str.should eq [["2013-11-27", 10.0], ["2013-11-28", 30.0], ["2013-11-29", 60.0]]
    end
  end

  describe "#to_date" do

    it "should convert julian dates to dates" do
      subject.to_date.first.first.should be_a Date
    end

  end

  describe "#to_json" do
    it "should convert the data_array to json and back" do
      JSON.parse(subject.to_json).should eq JSON.parse(subject.send(:data_array).to_json)
    end
  end

  describe "#as_json" do
    it "should be a representation of data_array" do
      subject.as_json.should eq subject.send(:data_array).as_json
    end
  end

  describe "#trim_end" do

    it "should delete everything after trim_end" do
      data = Quandl::Fabricate::Data.rand({ nils: false, rows: 10, columns: 1 }).sort_descending
      date = data[1][0]
      data.trim_end!(date)
      data.send(:data_array).should be_a Array
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

  describe "#trim_start" do

    it "should delete everything before trim_start" do
      data = Quandl::Fabricate::Data.rand({ nils: false, rows: 10, columns: 1 }).sort_descending
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

  describe "#to_csv" do

    its(:to_csv){ should be_a String }

    it "should output jd csv that is consistent with subject" do
      expected_data = subject.to_jd
      data = CSV.parse( expected_data.to_csv ).collect{|r| r.collect{|v| v.to_f } }
      data.should eq expected_data
    end

    it "should output date csv that is consistent with subject" do
      expected_data = subject.to_date
      data = CSV.parse( expected_data.to_csv ).collect{|r|
        date = Date.parse(r[0])
        row = r[1..-1].collect{|v| v.to_f }
        row.unshift(date)
        row
      }
      data.should eq expected_data
    end

    it "should output csv when initialized with a Quandl::Data" do
      Quandl::Data.new( subject ).to_csv.should eq subject.to_csv
    end

  end

end
