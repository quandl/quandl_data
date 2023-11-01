module Quandl
module Fabricate
class Data

  def self.rand(args = {})
    new(args).random
  end

  attr_accessor :attributes, :offset, :rows, :columns, :frequency, :data, :nils

  def initialize(args = {})
    self.attributes = default_options.merge args
  end

  def to_csv(args)
    data.collect(&:to_csv).join
  end

  def random_column
    self.columns = 1
    random
  end

  def random
    data = []
    index = 0
    until data.count >= rows
      data << row(index) unless nils
      index += 1
    end
    Quandl::Data.new( data ).to_precision!(14).sort_descending
  end

  def row(index)
    row = [ date(index) ]
    columns.times{|column_index| row << point(index, column_index) }
    row
  end

  def date(index)
    (Date.today - ( index * ( frequencies[frequency] ) - offset ))
  end

  def point(row_index, column_index)
    percent = ( (rand(10).to_f / 1000) ) - ( (rand(10).to_f / 850) ) + 1
    # increase the value
    trending_point[column_index] ||= column_index * column_index + 10
    trending_point[column_index] = trending_point[column_index] * percent
    # increase
    nils ? nil : trending_point[column_index]
  end

  def trending_point
    @trending_point ||= {}
  end

  def nils
    @nils == false ? false : rand(6) == 1
  end

  def frequencies
    {daily: 1, weekly: 7, monthly: 30, quarterly: 90, annual: 365}
  end

  def default_options
    {
      offset:     1,
      rows:       20 + rand(100),
      columns:    2 + rand(4),
      frequency:  :daily,
      monkey:     6
    }
  end

  def attributes
    @attributes ||= {}
  end

  def attributes=(attrs)
    assign_attributes(attrs)
    attributes
  end

  # mass assignment protection
  def assign_attributes(attrs)
    attrs.each do |name, value|
      self.send("#{name}=", value) if self.respond_to?("#{name}=")
    end
  end

end
end
end
