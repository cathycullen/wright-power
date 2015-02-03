require 'sinatra'
require 'dotenv'


puts "initialize.rb called"
Dotenv.load

configure do
  set :environment =>  ENV['RACK_ENV']
end

set :protection, :except => [:http_origin]

use Rack::Protection::HttpOrigin, :origin_whitelist => ['http://localhost:8000']

