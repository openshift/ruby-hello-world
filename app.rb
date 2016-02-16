require 'sinatra'
require_relative 'config/database'
require_relative 'models'

set :bind, '0.0.0.0'
set :port, 8080

def configure_database
  if ENV['RACK_ENV']=="production"
    while !self.connect_to_database_prod
      sleep 0.1
    end
  else
    while !self.connect_to_database_test
      sleep 0.1
    end
  end
  puts "Connected to database"
  puts "Create database..."
  %x"rake db:create"
  puts "Run migrations..."
  %x"rake db:migrate"
end

configure do
  puts "Run app..."

  unless ENV["DATABASE_SERVICE_HOST"].nil? && ENV["DATABASE_TEST_SERVICE_HOST"].nil?
    configure_database
  end
end

get '/' do
  puts "Servicing index request..."
  erb :main
end

get '/keys' do
  puts "Retrieving all keys"
  a={}
  KeyPair.all.each do |v|
    a[v.key]=v.value
  end
  a.to_s
end

get '/keys/:id' do
  puts "Retrieving key #{params[:id]}"
  if KeyPair.exists?(params[:id])
    KeyPair.find(params[:id]).value
  else
    not_found "Key not found"
  end
end

post '/keys/:id' do
  puts "Updating key #{params[:id]} to #{params['value']}"
  if KeyPair.exists?(params[:id])
    KeyPair.update(params[:id], value: params['value'])
    "Key updated"
  else
    KeyPair.create(key:params[:id],value:params['value']).save
    "Key created"
  end
end

delete '/keys/:id' do
  puts "Deleting key #{params[:id]}"
  if KeyPair.exists?(params[:id])
    v=KeyPair.find(params[:id])
    v.destroy
    "Key deleted"
  else
    "Key not found"
  end
end
