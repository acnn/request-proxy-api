# Proxy API
### About
Proxy API, as the name suggests, is an API for making proxy HTTPS requests. It is built using Ruby on Rails and exposes an API to receive POST requests at /proxy. It expects the following parameters,
- _**client_id**_ -  an unique identifier for each proxy API client. Each client id is allowed only 50 requests per minute.
- _**url**_ - the URL to which the proxy request has to be made. Accepts only HTTPS URLs.
- _headers_ - a JSON string representing the HTTP headers to be sent along with the proxy request. 
- _**http_method**_ - the HTTP method to be used for the proxy request. Examples: GET, POST (case sensitive).
- _request_body_ - the body of the proxy request.

_(Mandatory fields are marked as bold)_


### Setup

Proxy API requires Ruby 2.5.1 and Rails 5.2.3 to run. Also it requires the ports 3000 and 6379 to be open.

The project includes a _docker-compose.yml_ file which can be used to easily setup and host the API by running the following command from the project root folder,
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

##### The Proxy API should now be up at localhost:3000/proxy if everything went well :)





_Note: This is my first RoR application. So please feel free to point out any wrong conventions used in the code._