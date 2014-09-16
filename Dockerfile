FROM dockerfile/ruby

RUN gem install sinatra
ADD https://raw.githubusercontent.com/bparees/ruby_hello_world/master/app.rb /tmp/app.rb

EXPOSE 8080
CMD ["/usr/bin/ruby","/tmp/app.rb"]

