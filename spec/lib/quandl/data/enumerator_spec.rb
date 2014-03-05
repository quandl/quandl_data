# encoding: utf-8
require 'spec_helper'

describe Quandl::Data::Enumerator do

  let(:data){ Quandl::Fabricate::Data.rand( nils: false, rows: 4, columns: 4 ) }
  subject { data }

  its(:to_h){ should be_a Hash }
  its(:count){ should eq 4 }

  describe "#==" do
    it{ should eq data.to_a }
  end

  [nil, :to_jd, :to_date].each do |date_format|
    [nil, :to_a, :to_csv].each do |format|
      describe ".new(data.#{date_format}.#{format})" do
        let(:raw){
          raw = data
          raw = raw.send(date_format) if date_format.present?
          raw = raw.send(format) if format.present?
          raw
        }
        subject{ Quandl::Data.new(raw.clone) }
        
        it "subject.to_jd.first.first" do
          # binding.pry if date_format == nil && format == :to_csv
          puts subject.to_jd.first.first
        end
        
        its('to_jd.first.first'){ should be_a Integer }
        its('to_date.first.first'){ should be_a Date }
        
      end
      
    end
  end
  
end