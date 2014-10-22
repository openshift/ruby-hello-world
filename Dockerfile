FROM openshift/ruby-20-centos

RUN scl enable ruby193 "gem install sinatra"
ADD app.rb /tmp/app.rb

EXPOSE 8080
CMD scl enable ruby193 "ruby /tmp/app.rb"

