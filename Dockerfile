FROM ubuntu

RUN apt-get update \
  && apt-get install -y vim curl nginx \
  && rm -rf /var/www/html/*

COPY HTMLCSS-LandingPage-master /var/www/html

EXPOSE 80

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]


