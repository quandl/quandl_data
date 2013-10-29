# encoding: utf-8
require 'spec_helper'

describe Quandl::Data::Enumerator do

  let(:data){ Quandl::Fabricate::Data.rand( nils: false, rows: 4, columns: 4 ) }
  subject { data }

  its(:to_h){ should be_a Hash }
  its(:count){ should eq 4 }

  describe "#==" do
    it{ should eq data.data_array }
  end

end