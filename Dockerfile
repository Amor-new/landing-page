FROM ubuntu:22.04

# Install nginx
RUN apt-get update && apt-get install -y nginx

# Copy your landing page
COPY HTMLCSS-LandingPage-master/ /var/www/html/

# Expose HTTP port
EXPOSE 80

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
