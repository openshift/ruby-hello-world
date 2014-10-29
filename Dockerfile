FROM openshift/ruby-20-centos

# Install mysql client and gems to connect app to database.
USER root
RUN yum install -y mysql && gem install sinatra activerecord mysql2 --no-ri --no-rdoc

USER ruby
ADD app.rb /tmp/app.rb

EXPOSE 8080
ENTRYPOINT ["ruby", "/tmp/app.rb"]
