FROM rhscl/ruby-25-rhel7
USER default
EXPOSE 8080
ENV RACK_ENV production
ENV RAILS_ENV production
RUN mkdir -p /opt/app-root/src
RUN chmod  og+rw /opt/app-root/src
ADD . /opt/app-root/src/.
ENV GEM_HOME ~/.gem
RUN scl enable rh-ruby25 "bundle install"
CMD ["scl", "enable", "rh-ruby25", "./run.sh"]

USER root
RUN chmod og+rw /opt/app-root/src/db
USER default
