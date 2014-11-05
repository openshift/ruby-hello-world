require 'sinatra'
require_relative 'config/database'
require_relative 'models'

set :bind, '0.0.0.0'
set :port, 8080

configure do
  puts "Running app file"
  puts "Create database..."
  %x"rake db:create"
  puts "Run migrations..."
  %x"rake db:migrate"
  puts "Run app..."

  while !self.connect_to_database
    puts "Connecting to database...\n"
    sleep 0.1
  end
  puts "Connected to database"
end

get '/' do
  File.read('main.html')
end

get '/keys' do
  a={}
  KeyPair.all.each do |v|
    a[v.key]=v.value
  end
  a.to_s
end

get '/keys/:id' do
  if KeyPair.exists?(params[:id])
    KeyPair.find(params[:id]).value
  else
    not_found "Key not found"
  end
end

post '/keys/:id' do
  if KeyPair.exists?(params[:id])
    KeyPair.update(params['id'], value: params['value']) 
    "Key updated"
  else
    KeyPair.create(key:params[:id],value:params['value']).save
    "Key created"
  end
end
  
delete '/keys/:id' do
  if KeyPair.exists?(params[:id])
    v=KeyPair.find(params[:id])
    v.destroy
    "Key deleted"
  else
    "Key not found"
  end
end
