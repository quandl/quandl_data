## 1.4.0 

* Version bump to 1.4.0
* revise verison location
* add quandl_utility
* data needs to be cloned before cleaning to ensure pristine data remains untouched. remove quandl data extraction since it happens at initialize
* validation will unset cleaned flag
* refactor quandl data to use quandl/support/attributes ... internal data is stored in attributes and can be passed around more easily.
* add quandl/support/attributes
* QUGC-104 refactored Quandl::Data to use valid? and errors. Invalid data will not cause a standard error to be raised, it will just add it to data.errors
* Merge branch 'master' into develop
* Release 1.3.9. add malformed_csv spec and error catching
* add malformed_csv spec and error catching.
* revise spec
* Release 1.3.8. Data#headers should be passed around between Data#new
* Data#headers should be passed around between Data#new
* minor version
* Release 1.3.7. revise Quandl::Data#frequency to use Quandl::Babelfish.guess_frequency
* revise Quandl::Data#frequency to use Quandl::Babelfish.guess_frequency
* Release 1.3.6. Add #guess_csv_delimiter to Data::Format.
* Add #guess_csv_delimiter to Data::Format. QUGC-5
* Release 1.3.5. add Validations, #valid? #errors. refactor format errors to be raised with line, context, row
* add Validations, #valid? #errors
* add Data#to_table that returns self. Useful in conjunction with search scopes
* refactor format errors to be raised with line, context, row
* Release 1.3.4. add #to_precision(Integer)
* fabricated data is forced to precision of 14
* add precision
* Release 1.3.3. integrate Babelfish.clean as part of Quandl::Data.clean method
* integrate Babelfish.clean as part of Quandl::Data.clean method.     known_format?( data ) ? clean_with_format(data) : clean_with_babelfish(data)
* Release 1.3.2.
* add babelfish as a dependency. Add Quandl::Babelfish::Data.
* Release 1.3.1. Remove Babelfish. Refactor Data::Errors to Quandl::Error'
* Merge branch 'develop'
* add .with_type to Data
* Merge branch 'feature/refactor_babelfish' into develop
* revise errors to Error for consistency
* remove babelfisher
* refactor babelfish out of data
* Release 1.3.0. Add babelfish for cleaning data'
* remove logging
* string_to_csv will not force values to float. Allow babelfish to handle this. Format#parse will force values to float. Used by Quandl::Cassandra::Data since it is a lot faster than babelfish, and we trust C* data
* add #row to Operations. Operations will be passed data_array rather than to_jd.to_a
* add cleaned? cleaned! for tracking whether or not a Quandl::Data instance has already been cleaned. #clean will short circuit if the data is already cleaned
* remove julian dates
* return [] when given blank data.
* add Data.new_with_jd for converting julian dates to ruby date. revise #clone to pass headers
* replace parse with babelfish#clean
* add babelfisher for cleaning data
* add Quandl::Babelfish.clean to replace Quandl::Data::Format.parse
* upgrade info
* bump quandl_operation
* refactor sorting into Quandl::Operation::Sort
* import Quandl::Data::Format from Quandl::Operation ... import specs
* remove data parse
* add Quandl::Data::Parse, Date, Value and specs
* Release 1.2.1. add Data#to_date_str that returns data as "yyyy-mm-dd"
* add Data#to_date_str that returns data as "yyyy-mm-dd"
* Release 1.2.0. data returns Dates instead of Julian Dates
* refactor operation definitions
* add local gems
* Release 1.1.4.
* only force incoming data to_a if it is kind_of Quandl::Data
* Release 1.1.3.
* make Data.new specs pass
* add Guard
* write failing specs for random cases where Quandl::Data.new given Date, JulianDate, Integer.
* Release 1.1.2.
* add simplecov
* Release 1.1.1. fabricate require error
* fix fabricate data require error
* refactor tests
* Release 1.1.0.
* it rejects invalid transforms
* it should reject invalid collapse
* Release 1.0.0. -m
* refactor Quandl::Data::Table to Quandl::Data refactor Quandl::Fabricate::Data::Table to Quandl::Fabricate::Data bump version to 0.2.0
* bump quandl_operation to make cumul spec pass
* write failing spec for cumul
* Release 0.1.11.
* add quandl/fabricate/data. deprecate Quandl::Data::Random.table
* Release 0.1.10. activesupport
* Release 0.1.9. use pessimistic operator for runtime dependencies
* Release 0.1.8. should output csv when initialized with a Data::Table
* Release 0.1.7. bump quandl_operation
* Release 0.1.6. as_json should delegate to data_array
* Release 0.1.5. data_array should convert the data_array to json and back
* it should convert the data_array to json and back
* Release 0.1.4. add specs to test that operations do not alter the original data.
* revise trim_start and trim_end to check each row and delete_if
* bump quandl_operation to add support for rdiff_from
* initial release
* add bad index check.
* add trim_start trim_end
* add limit
* add pristine data to permit lazy parsing. only parse data if methods requiring awareness of data are called.
* logging is revised to use Quandl::Logger.
* add loggable
* bump versions to use revised operaiton
* requires quandl_operation 0.0.6
* bump version
* some specs
* add Random



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