FROM dockerfile/ruby

RUN gem install sinatra
ADD https://raw.githubusercontent.com/bparees/origin_ruby_sample/master/app.rb /tmp/app.rb

EXPOSE 8080
CMD ["/usr/bin/ruby","/tmp/app.rb"]

