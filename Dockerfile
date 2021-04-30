FROM quay.io/centos7/ruby-27-centos7
USER default
EXPOSE 8080
ENV RACK_ENV production
ENV RAILS_ENV production
COPY . /opt/app-root/src/
ENV GEM_HOME ~/.gem
RUN scl enable rh-ruby27 "bundle install"
CMD ["scl", "enable", "rh-ruby27", "./run.sh"]

USER root
RUN chmod og+rw /opt/app-root/src/db
USER default
