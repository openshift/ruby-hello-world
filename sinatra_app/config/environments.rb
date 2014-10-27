require 'sinatra/activerecord'

def self.connect_to_database
  begin
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :host     => "#{ENV["DATABASE_SERVICE_IP_ADDR"]}",
      :port     => "#{ENV["DATABASE_SERVICE_PORT"]}",
      :database => "#{ENV["MYSQL_DATABASE"]}",
      :password => "#{ENV["MYSQL_ROOT_PASSWORD"]}"
    )

    ActiveRecord::Base.connection.active?

  rescue Exception
    return false
  end
end

configure :development do

  while !self.connect_to_database
    puts "Connecting to database...\n"
    sleep 0.1
  end
  puts "Connected to database"
end
