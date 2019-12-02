# README

# Rails Engine API

**Built in:**
*Ruby 2.5.0*
*Rails 5.1.7*
*MacOS*

## Setup

1. Clone the latest version @ https://github.com/Jonpatt92/Rails_Engine  
2. Navigate inside the `rails_engine` directory and run the following commands in your terminal.
3. Run `bundle install` + `bundle update` + `bundle` to prep the gemfile.
4. Run `rake db:create` + `rake db:migrate` to create the databases.
5. Run `rake import_csv` to import csv data into the databases.
6. Run `rspec` to initiate the testing suite and verify the app is ready.
7. Run `rails s` to initiate a local server on your machine.
8. Open your browser and navigate to http://localhost:3000/api/v1 + the desired endpoint. All further described endpoints will be situated after this path.

## Data Sets
**There are 6 sets of data, each using a similar structure for endpoints**  

## Merchants
### Standard Endpoints:
* `/merchants` :: Lists **all merchants**, their *attributes*, and *relationships*.  
* `/merchants/:merchant_id` :: Lists the *attributes* and *relationships* for the **merchant** belonging to the id provided.  
* `/merchants/random` :: Lists the *attributes* and *relationships* for a random **merchant**.  

### Search Endpoints
These endpoints will search through all merchants who have the attribute corresponding with what you enter after the `=`.  
Spaces are represented with `%20`.  
*ex: /merchants/find?name=alan%20turing*  

`find` queries will return a **single merchant**, its *attributes* and *relationships*.  

`find_all` queries will return **all merchants** that match the query, their *attributes* and *relationships*.  

`created_at` && `updated_at` queries reference the entire day, in the following format `2012-03-27`  

*ex: /merchants/find?created_at=2012-03-27*  


* `/merchants/find?id=`
* `/merchants/find_all?id=`  

* `/merchants/find?name=`
* `/merchants/find_all?name=`  

* `/merchants/find?created_at=`
* `/merchants/find_all?created_at=`  

* `/merchants/find?updated_at=`
* `/merchants/find_all?updated_at=`

## Customers
### Standard Endpoints:
* `/customers` :: Lists **all customers**, their *attributes*, and *relationships*.  
* `/customers/:customer_id` :: Lists the *attributes* and *relationships* for the **customer** belonging to the id provided.  
* `/customers/random` :: Lists the *attributes* and *relationships* for a random **customer**.  

### Search Endpoints
These endpoints will search through all customers who have the attribute corresponding with what you enter after the `=`.  
Spaces are represented with `%20`.  
*ex: /customers/find?name=alan%20turing*  

`find` queries will return a **single customer**, its *attributes* and *relationships*.  

`find_all` queries will return **all customers** that match the query, their *attributes* and *relationships*.  

`created_at` && `updated_at` queries reference the entire day, in the following format `2012-03-27`  

*ex: /customers/find?created_at=2012-03-27*  


* `/customers/find?id=`
* `/customers/find_all?id=`  

* `/customers/find?first_name=`
* `/customers/find_all?first_name=`  

* `/customers/find?last_name=`
* `/customers/find_all?last_name=`  

* `/customers/find?created_at=`
* `/customers/find_all?created_at=`  

* `/customers/find?updated_at=`
* `/customers/find_all?updated_at=`  


## Items
### Standard Endpoints:
* `/items` :: Lists **all items**, their *attributes*, and *relationships*.  
* `/items/:item_id` :: Lists the *attributes* and *relationships* for the **item** belonging to the id provided.  
* `/items/random` :: Lists the *attributes* and *relationships* for a random **item**.  

### Search Endpoints
These endpoints will search through all items who have the attribute corresponding with what you enter after the `=`.  
Spaces are represented with `%20`.  
*ex: /items/find?name=alan%20turing*  

`find` queries will return a **single item**, its *attributes* and *relationships*.  

`find_all` queries will return **all items** that match the query, their *attributes* and *relationships*.  

`created_at` && `updated_at` queries reference the entire day, in the following format `2012-03-27`  

*ex: /items/find?created_at=2012-03-27*  


* `/items/find?id=`
* `/items/find_all?id=`  

* `/items/find?name=`
* `/items/find_all?name=`  

* `/items/find?description=`
* `/items/find_all?description=`  

* `/items/find?unit_price=`  *This will be a number with two decimal places*
* `/items/find_all?unit_price=`  *ex: 1.00*

* `/items/find?created_at=`
* `/items/find_all?created_at=`  

* `/items/find?updated_at=`
* `/items/find_all?updated_at=`  

* `/items/find?merchant_id=`  *This is the id of the merchant this item belongs to*
* `/items/find_all?merchant_id=`  


## Invoices
### Standard Endpoints:
* `/invoices` :: Lists **all invoices**, their *attributes*, and *relationships*.  
* `/invoices/:invoice_id` :: Lists the *attributes* and *relationships* for the **invoice** belonging to the id provided.  
* `/invoices/random` :: Lists the *attributes* and *relationships* for a random **invoice**.  

### Search Endpoints
These endpoints will search through all invoices who have the attribute corresponding with what you enter after the `=`.  
Spaces are represented with `%20`.  
*ex: /invoices/find?name=alan%20turing*  

`find` queries will return a **single invoice**, its *attributes* and *relationships*.  

`find_all` queries will return **all invoices** that match the query, their *attributes* and *relationships*.  

`created_at` && `updated_at` queries reference the entire day, in the following format `2012-03-27`  

*ex: /invoices/find?created_at=2012-03-27*  


* `/invoices/find?id=`
* `/invoices/find_all?id=`  

* `/invoices/find?status=`  *This will usually be 'shipped'*
* `/invoices/find_all?status=`  

* `/invoices/find?created_at=`
* `/invoices/find_all?created_at=`  

* `/invoices/find?updated_at=`
* `/invoices/find_all?updated_at=`  

* `/invoices/find?customer_id=` *The id of the customer this invoice belongs to*
* `/invoices/find_all?customer_id=`  

* `/invoices/find?merchant_id=` *The id of the merchant this invoice belongs to*
* `/invoices/find_all?merchant_id=`  



## Invoice Items (Join Table between Invoices and Items)
### Standard Endpoints:
* `/invoice_items` :: Lists **all invoice items**, their *attributes*, and *relationships*.  
* `/invoice_items/:invoice_item_id` :: Lists the *attributes* and *relationships* for the **invoice item** belonging to the id provided.  
* `/invoice_items/random` :: Lists the *attributes* and *relationships* for a random **invoice item**.  

### Search Endpoints
These endpoints will search through all invoice_items who have the attribute corresponding with what you enter after the `=`.  
Spaces are represented with `%20`.  
*ex: /invoice_items/find?name=alan%20turing*  

`find` queries will return a **single invoice item**, its *attributes* and *relationships*.  

`find_all` queries will return **all invoice items** that match the query, their *attributes* and *relationships*.  

`created_at` && `updated_at` queries reference the entire day, in the following format `2012-03-27`  

*ex: /invoice_items/find?created_at=2012-03-27*  


* `/invoice_items/find?id=`
* `/invoice_items/find_all?id=`  

* `/invoice_items/find?quantity=`  *integer, ex: 3*
* `/invoice_items/find_all?quantity=`  

* `/invoice_items/find?unit_price=`  *This will be a number with two decimal places*
* `/invoice_items/find_all?unit_price=`  *ex: 1.00*

* `/invoice_items/find?created_at=`
* `/invoice_items/find_all?created_at=`  

* `/invoice_items/find?updated_at=`
* `/invoice_items/find_all?updated_at=`  

* `/invoice_items/find?invoice_id=` *The id of the invoice this invoice_item belongs to*
* `/invoice_items/find_all?invoice_id=`  

* `/invoice_items/find?item_id=` *The id of the item this invoice_item belongs to*
* `/invoice_items/find_all?item_id=`  


## Transactions
### Standard Endpoints:
* `/transactions` :: Lists **all transactions**, their *attributes*, and *relationships*.  
* `/transactions/:transaction_id` :: Lists the *attributes* and *relationships* for the **transaction** belonging to the id provided.  
* `/transactions/random` :: Lists the *attributes* and *relationships* for a random **transaction**.  

### Search Endpoints
These endpoints will search through all transactions who have the attribute corresponding with what you enter after the `=`.  
Spaces are represented with `%20`.  
*ex: /transactions/find?name=alan%20turing*  

`find` queries will return a **single transaction**, its *attributes* and *relationships*.  

`find_all` queries will return **all transactions** that match the query, their *attributes* and *relationships*.  

`created_at` && `updated_at` queries reference the entire day, in the following format `2012-03-27`  

*ex: /transactions/find?created_at=2012-03-27*  


* `/transactions/find?id=`
* `/transactions/find_all?id=`  

* `/transactions/find?credit_card_number=`
* `/transactions/find_all?credit_card_number=`  

* `/transactions/find?result=`  *This will either be 'success' or 'failed'*
* `/transactions/find_all?result=`  

* `/transactions/find?created_at=`
* `/transactions/find_all?created_at=`  

* `/transactions/find?updated_at=`
* `/transactions/find_all?updated_at=`  

* `/transactions/find?invoice_id=`  *This is the id of the invoice this transaction belongs to*
* `/transactions/find_all?invoice_id=`  
