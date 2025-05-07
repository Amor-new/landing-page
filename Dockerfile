FROM ubuntu:22.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install nginx, curl, and Node.js prerequisites
RUN apt-get update && \
    apt-get install -y nginx curl gnupg2 ca-certificates lsb-release software-properties-common

# Install Node.js 18 (includes npm)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs

# Install Snyk CLI
RUN npm install -g snyk

# Copy your landing page
COPY HTMLCSS-LandingPage-master/ /var/www/html/

# Expose HTTP port
EXPOSE 80

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
