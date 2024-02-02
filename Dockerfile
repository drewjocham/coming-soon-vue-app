FROM nginx:1.25.2-alpine

WORKDIR /etc/nginx

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

EXPOSE 8080
EXPOSE 80

CMD ["/usr/sbin/nginx"]
