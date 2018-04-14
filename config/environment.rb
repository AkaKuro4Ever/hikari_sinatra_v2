#We now have access to all of the gems that we need, but we still need to setup a connection to our database
ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'

Bundler.require(:default, ENV['SINATRA_ENV'])
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)
# configure :development do
#   set :database, 'sqlite3:db/database.db'
# end

require_all 'app'
#This sets up a connection to a sqlite3 database named "database.db", located in a folder called "db." If we wanted our .db file to be called dogs.db, we could simply change the name of this file:
#		configure :development do
#		  set :database, 'sqlite3:db/dogs.db'
#		end
