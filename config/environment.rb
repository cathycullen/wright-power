# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'dotenv'
require 'action_mailer'

require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/cookies'
require 'bcrypt'
require './lib/terse_params_logger'
require 'chartkick'

use TerseParamsLogger

require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

Dotenv.load

configure do
  # By default, Sinatra assumes that the root is the file that calls the configure block.
  # Since this is not the case for us, we set it manually.
  set :root, APP_ROOT.to_path
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || '2d3fb6b5cedf176eba620135432d70197c4394972dda5509ab7601ebf1e137ff'

  # Set the views to
  set :views, File.join(Sinatra::Application.root, "app", "views")
end


# Set up the database and models
require APP_ROOT.join('config', 'database')
require APP_ROOT.join('config', 'constant')


# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

before '*' do
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type"
  response.headers['Access-Control-Allow-Credentials'] = 'true'
  I18n.enforce_available_locales = false
end
