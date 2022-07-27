#!/usr/bin/env bash

set -Eeuo pipefail

cd /root/growing-relic

mkdir -p /srv/growing-relic-api/run

bundle exec puma -b unix:///srv/growing-relic-api/run/app.socket
