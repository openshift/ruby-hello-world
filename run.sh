#!/bin/sh

# Helper script to run the sample app locally, assumes a local mysql instance with a
# login of root/root
if [ -z "${MYSQL_DATABASE}" ]; then
  export DATABASE_SERVICE_HOST=localhost
  export DATABASE_SERVICE_PORT=3306
  export MYSQL_DATABASE=test
  export MYSQL_ROOT_PASSWORD=root
fi

bundle exec ruby app.rb
