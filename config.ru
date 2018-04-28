require './config/environment'


use Rack::MethodOverride
run ApplicationController
run BookController
