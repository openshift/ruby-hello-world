require 'sinatra'
require_relative 'config/environments'
require_relative 'models'

set :bind, '0.0.0.0'
set :port, ENV["FRONTEND_SERVICE_PORT"]

get '/' do
  Timestamp.create(date: Time.now, text: "This is a message from a database query. The last insertion in the database was at")
  "Hello World!\n"+
  # ENV values are generated during template processing
  # and then passed to the container when openshift launches it.
  "All the environment variables are: #{ENV.map { |k,v| "#{k}=#{v}" }.join("\n")}]\n" +
  "#{Timestamp.last().text} #{Timestamp.last().date}."
end
