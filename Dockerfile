FROM nginx:1.19-alpine

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*
RUN rm -rf /etc/nginx/*
RUN mkdir /usr/share/nginx/html/personal

## Copy the template and mime types
COPY config/nginx.conf.template /etc/nginx/nginx.conf
COPY config/mime.types /etc/nginx/mime.types

## Log to stdout / stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

## Copy the dist folder to the webroot
COPY ./dist /usr/share/nginx/html/personal
RUN chmod 755 -R /usr/share/nginx/html/*

COPY setup.sh setup.sh
# # Make our shell script executable
RUN chmod +x setup.sh

# copy package.json for cloud run
COPY package.json package.json

WORKDIR /etc/nginx

EXPOSE 8080
EXPOSE 80

## Run the startup script instead og nginx to be able to use env vars on startup
#CMD ["/usr/sbin/nginx"]
CMD ["/bin/bash", "-c", "/etc/nginxstart.sh && nginx -g 'daemon off;'"]
