#!/bin/bash

set -o pipefail -u

rake db:exists && rake db:migrate || rake db:setup

exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
