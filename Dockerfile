FROM nginx
LABEL maintainer="John Smith<john.smith@gmail.com>"

COPY ./website /website
COPY ./nginx.conf /etc/nginx/nginx.conf