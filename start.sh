#!/bin/bash

if [ ! -d "/dist" ]
then
    echo "npm install"
    npm install

    echo "start npm build"
    npm run build
    echo "Build finished...";

    echo "Delete node_modules folder";
    rm -rf node_modules
    ls -all
    echo "START COPY";
    cp -R  dist/* /usr/share/nginx/html/personal
    chmod 755 -R /usr/share/nginx/html/*
    echo "END COPY";

    echo "Starting nginx"
    exec /usr/sbin/nginx
fi

