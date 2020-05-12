# E-Commerce Website

This is a team project that features an ecommerce website with different roles (admin, seller, buyer , guest) using Ruby on Rails.

## What you can do 
* All roles can view products, its price and details.
* As buyer, you can add products to your cart and order all selected products with all requirements to finish order delivery process, rate the product and write a review on it, etc ..
* As seller, you act as a buyer in addition to add new products and change the order states.

* As admin, you have all permisions in the system.

## Unfunctional Requirements
* page caching
* API for products index and show product
* model unit test 
* email sending process occurs in background 

### Team Members:
	 Ahmed Abdelhamid - Muhammad Aladdin - Nouran Samy - Zeyad Saleh

### Prerequisites

you should setup your environment from [here](https://gorails.com/setup).

### Installing
1. Download the zipped file and unzip it or Clone it
		```
	 	https://github.com/Nouran96/ecommerce_rails.git
		```
2. cd inside the project
    ```sh
    cd ecommerce_rails
    ```
3.  Run this command to install all gems we used
    ```sh
    bundle install
    ```
4. Create file called 'local_env.yml' in /config with these lines:
    ```sh
    MAIL_USERNAME: 'your_email_that_used_to_send_welcome_emails'
    MAIL_PASSWORD: 'your password'
    DATABASE_USERNAME: 'your database username'
    DATABASE_PASSWORD: 'your password'
    ```
5. run this command to create your database
    ```sh
    rake db:create db:migrate
    ```
6. seed the database - generate fake test data
    ```sh
    rails db:seed
    ```
7. Start your server
    ```sh
    rails server
    ```
8. Open your browser on this url ``` http://localhost:3000```

### License
MIT License

Copyright (c) 2020 ZAMN Team

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.