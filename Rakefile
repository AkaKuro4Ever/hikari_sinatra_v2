#As we mentioned, rake gives us the ability to quickly make files and setup automated tasks. We define these in a file called Rakefile. First, create a Rakefile in the root of our project directory. In the Rakefile, we'll require our config/environment.rb file to load up our environment, as well as "sinatra/activerecord/rake" to get Rake tasks from the sinatra-activerecord gem.

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc 'drop into the Pry console'
		task :console do
		  Pry.start
		end
