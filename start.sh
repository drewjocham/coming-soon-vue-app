#!/bin/bash

if [ ! -d "/dist" ]
then
    echo "start npm install"
    npm install

    echo "start npm build"
    npm run build
    echo "Build finished...";

    echo "Delete node_modules folder";
    rm -rf node_modules

    echo "START COPY";
    cp -rf  dist/. /usr/share/nginx/html/personal
    chmod 755 -R /usr/share/nginx/html/*
    echo "END COPY";

    echo "Starting nginx"
fi

