## 1.4.1 





## 1.4.0 

* QUGC-104 refactored Quandl::Data to use valid? and errors.



## 1.3.9

* add malformed_csv spec and error catching


## 1.3.8

* Data#headers should be passed around between Data#new


## 1.3.7

* revise Quandl::Data#frequency to use Quandl::Babelfish.guess_frequency


## 1.3.6

* Add #guess_csv_delimiter to Data::Format.


## 1.3.5

* add Validations, #valid? #errors
* add Data#to_table that returns self. Useful in conjunction with search scopes
* refactor format errors to be raised with line, context, row


## 1.3.4

* add #to_precision(Integer)
* fabricated data is forced to precision 14


## 1.3.3

* integrate Babelfish.clean as part of Quandl::Data.clean method.
* Remove Quandl::Babelfish::Data


## 1.3.2

* readd quandl_babelfish as a dependency
* Add Quandl::Babelfish::Data


## 1.3.1

* add .with_type to Data
* revise errors to Error for consistency
* refactor babelfish out of data, remove babelfisher


## 1.3.0

* string_to_csv will not force values to float
* add #row to Operations
* add cleaned? cleaned! for tracking whether or not a Quandl::Data instance has already been cleaned
* replace parse with babelfish#clean
* add Quandl::Babelfish.clean to replace Quandl::Data::Format.parse
* bump Quandl::Operation to 0.3.0 for Quandl::Operation::Sort
* refactor sorting into Quandl::Operation::Sort
* import Quandl::Data::Format from Quandl::Operation
* remove data parse


## 1.2.1

* add Data#to_date_str that returns data as "yyyy-mm-dd"


## 1.2.0

* bump quandl_operation, data returns Dates instead of Julian Dates


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