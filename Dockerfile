FROM openshift/ruby-20-centos

RUN gem install sinatra sinatra-activerecord mysql2 --no-ri --no-rdoc

ADD sinatra_app /tmp/
WORKDIR /tmp/

EXPOSE 8080
CMD ["ruby", "start.rb"]
