FROM openshift/ruby-20-centos7

USER default

COPY . /opt/openshift/src/
RUN scl enable ror40 "bundle install"
ENV RACK_ENV="production",RAILS_ENV="production"
EXPOSE 8080
CMD ["scl", "enable", "ror40", "./run.sh"]
