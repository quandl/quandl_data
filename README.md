# Quandl::Data

## Purpose

Array-like class for loading, modifying, and dumping time-series data.



## Installation

```ruby
gem 'quandl_data'
```



## Usage

### Load

```ruby
require 'quandl/data'

csv = "2014,9.9982352941176,\n2013,,10.960561384083\n2012,10.101388852042,10.960561384083\n"
table = Quandl::Data.new( csv )
table.to_precision(4)
# => [[Wed, 31 Dec 2014, 9.998, nil], [Tue, 31 Dec 2013, nil, 10.96], [Mon, 31 Dec 2012, 10.1, 10.96]]
```


### Modify

```ruby
require 'quandl/data'
require 'quandl/fabricate/data'

data = Quandl::Fabricate::Data.rand( rows: 24, columns: 2, nils: false )
data.collapse(:weekly).transform(:rdiff).to_precision(4).to_a
# => [[Sun, 16 Mar 2014, -1.454, -0.8842], [Sun, 09 Mar 2014, 0.02759, -0.2466], [Sun, 02 Mar 2014, 2.294, 0.2915]]
```


### Dump

```ruby
require 'quandl/data'
require 'quandl/fabricate/data'

data = Quandl::Fabricate::Data.rand( rows: 24, columns: 2, nils: false )
data.collapse(:weekly).transform(:rdiff).to_precision(4).to_csv
# => "2014-03-16,0.01004,-0.006875\n2014-03-09,-0.002372,-0.03461\n2014-03-02,0.00289,0.007114\n2014-02-23,0.008578,-0.01171\n"
```