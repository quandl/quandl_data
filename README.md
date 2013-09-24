# Quandl::Data

### Quandl::Data::Table

```ruby

require 'quandl/data'

decade_of_daily_data_as_csv = Quandl::Fabricate::Data::Table.rand( rows: 3650, columns: 4, nils: false ).to_csv

table = Quandl::Data::Table.new( decade_of_daily_data_as_csv )
table.collapse(:monthly).transform(:rdiff).to_date

```


### Quandl::Fabricate::Data::Table

```ruby

require 'quandl/fabricate/data'

data = Quandl::Fabricate::Data::Table.rand( rows: 4, columns: 2, nils: false )
data.to_csv

=> "2456459,9.75573946698621,11.003327581245657\n2456460,9.815208080651333,11.06123640714187\n2456461,9.85055418685121,11.054083764705883\n2456462,9.915882352941177,10.96635294117647\n"

```