#!/bin/bash

set -o pipefail -u

# Wait for the db service to be ready before continuing
echo "waiting for db..."  
while ! nc -w 1 -z $DB_HOST $DB_PORT 2>/dev/null;  
do  
  echo -n .
  sleep 1
done

rake db:exists && rake db:migrate || rake db:setup

exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
