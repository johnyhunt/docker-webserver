#!/bin/bash
set -e

if [ -n "${NEWRELIC_LICENSE}" ];
then
    rm -Rf "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    docker-php-ext-enable --ini-name 100-newrelic.ini newrelic.so
    echo "[newrelic]" >> "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    echo "newrelic.license = \"${NEWRELIC_LICENSE}\"" >> "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    newrelic-daemon --pidfile /var/run/newrelic-daemon.pid
fi

exec "$@"