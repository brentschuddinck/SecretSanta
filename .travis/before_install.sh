#!/usr/bin/env bash

cp /home/travis/.phpenv/versions/$(phpenv version-name)/etc/conf.d/xdebug.ini ~/xdebug.ini
phpenv config-rm xdebug.ini || exit $? # Disable XDebug
mkdir -p \"${BUILD_CACHE_DIR}\" || exit $? # Create build cache directory

# Download and configure geoip db
if [ ! -f $BUILD_CACHE_DIR/GeoLite2-City.mmdb ]; then
    curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz > geolite.tar.gz
    tar -xvzf geolite.tar.gz --strip=1

    mv GeoLite2-City.mmdb $BUILD_CACHE_DIR
fi

# Update composer to the latest stable release as the build env version is outdated
composer self-update --stable || exit $?
