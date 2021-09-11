#!/bin/bash

if [ ! -d "/app/dist" ]
then
    npm run build

    echo "Build finished...";

    echo "Delete node_modules folder";

    rm -rf node_modules

    echo "START COPY";

    cp -rf  /etc/nginx/dist/. /usr/share/nginx/html/personal

    echo "END COPY";
fi
