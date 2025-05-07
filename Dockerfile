FROM ubuntu:22.04
...
COPY HTMLCSS-LandingPage-master/ /var/www/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
