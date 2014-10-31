require 'sinatra'
require_relative 'config/environments'
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
  Timestamp.create(date: Time.now, text: "This is a message from a database query. The last insertion in the database was at")
  "Hello World!\n"+
  # ENV values are generated during template processing
  # and then passed to the container when openshift launches it.
  "All the environment variables are: #{ENV.map { |k,v| "#{k}=#{v}" }.join("\n")}]\n" +
  "#{Timestamp.last().text} #{Timestamp.last().date}."
end
