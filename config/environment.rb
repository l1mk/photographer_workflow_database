ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

#require 'database_cleaner/active_record'
#DatabaseCleaner.strategy = :truncation

require './app/models/concerns/slugifiable'
require './app/controllers/application_controller'
require_all 'app'
