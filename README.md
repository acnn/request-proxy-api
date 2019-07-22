# Proxy API
### About
Proxy API, as the name suggests, is an API for making proxy HTTPS requests. It is built using Ruby on Rails and exposes an api to receive POST requests at /proxy. It expects the following parameters,
- **client_id** -  an unique identifier for each proxy api client. Each client id is allowed only 50 requests per minute.
- **url** - the URL to which the proxy request has to be made. Accepts only HTTPS URLs.
- headers - a JSON string representing the HTTP headers to be sent along with the proxy request. 
- **http_method** - the HTTP method to be used for the proxy request. Example: GET, POST (case sensitive)
- request_body - the body of the proxy request

_(Mandatory fields are marked as bold)_


### Setup

Proxy API requires Ruby 2.5.1 and Rails 5.2.3 to run.

The project includes a docker-compose.yml file which can be used to easily setup and host the API by running the following command from the project root folder,
```sh
$ sudo docker-compose up --build
```

If you do not have docker installed, please follow the below commands to setup the API on Ubuntu. For Ruby...

```sh
$ sudo apt-get install ruby
$ ruby -v
```

...and for Rails...

```sh
$ sudo gem install rails
$ rails -v
```

...and run the below commands from the project root folder to verify if the tests are successful and then start the API.

```sh
$ bundle install
$ rspec
$ rails server
```

##### The Proxy API should now be up at localhost:3000/proxy if everything goes well :)

