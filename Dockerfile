FROM dockerfile/ruby

RUN gem install sinatra
ADD app.rb /tmp/app.rb

EXPOSE 8080
CMD ["/usr/bin/ruby","/tmp/app.rb"]

