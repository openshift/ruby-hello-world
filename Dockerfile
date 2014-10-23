FROM openshift/ruby-20-centos

# Install mysql client and gems to connect app to database.
USER root
RUN yum install -y mysql && gem install sinatra activerecord mysql2 --no-ri --no-rdoc
# FIXME: This should be the DATABASE_SERVICE_HOST environment variable,
# but the container doesn't know how to resolve the hostname now.
# It represents the database host, in case the app should connect to one.
ENV DATABASE_SERVICE_IP_ADDR 172.17.42.1

USER ruby
ADD app.rb /tmp/app.rb

EXPOSE 8080
ENTRYPOINT ["ruby", "/tmp/app.rb"]
