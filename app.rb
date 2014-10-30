require 'active_record'
require 'sinatra'

set :bind, '0.0.0.0'
set :port, 8080

if not ("#{ENV["MYSQL_DATABASE"]}".blank? || "#{ENV["MYSQL_ROOT_PASSWORD"]}".blank? || "#{ENV["DATABASE_SERVICE_HOST"]}".blank?)

  while  %x"mysqladmin ping -h #{ENV["DATABASE_SERVICE_HOST"]} --port=#{ENV["DATABASE_SERVICE_PORT"]} -uroot -p#{ENV["MYSQL_ROOT_PASSWORD"]}".strip != "mysqld is alive"
    puts "Waiting for database connection to #{ENV["DATABASE_SERVICE_HOST"]}:#{ENV["DATABASE_SERVICE_PORT"]} as ...#{ENV["MYSQL_ROOT_PASSWORD"]}\n"
    sleep 1
  end

  configure do
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :host     => "#{ENV["DATABASE_SERVICE_HOST"]}",
      :port     => "#{ENV["DATABASE_SERVICE_PORT"]}",
      :database => "#{ENV["MYSQL_DATABASE"]}",
      :password => "#{ENV["MYSQL_ROOT_PASSWORD"]}"
    )
  end
  puts "Database connection is OK."
end

get '/' do
  "Hello World!\n"+
  # ENV values are generated during template processing
  # and then passed to the container when openshift launches it.
  "All the environment variables are: #{ENV.map { |k,v| "#{k}=#{v}" }.join("\n")}]\n"
end
