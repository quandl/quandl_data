## 1.2.0

* bump quandl_operation, data now defaults to return Dates instead of Julian Dates


## 1.1.4

* force incoming data to_a if it is kind_of Quandl::Data
* write failing specs for random cases where Quandl::Data.new given Date, JulianDate, Integer


## 1.1.2

* bump quandl_operation && quandl_logger


## 1.1.0

* it rejects invalid transforms
* it rejects invalid collapse

## 1.0.0

* Quandl::Data::Table is removed. Replaced by: Quandl::Data
* Quandl::Fabricate::Data::Table is remove. Replaced by: Quandl::Fabricate::Data


## 0.1.11

* add quandl/fabricate/data. deprecate Quandl::Data::Random.table


## 0.1

* Initial