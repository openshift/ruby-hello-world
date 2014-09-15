require 'sinatra'

set :bind, '0.0.0.0'
set :port,8080
get '/' do
  "Hello World2!
User is #{ENV['ADMIN_USERNAME']}
Password is #{ENV['ADMIN_PASSWORD']}
DB password is #{ENV['DB_PASSWORD']}\n"

end
