FROM ubuntu:22.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install nginx, docker, kubectl dependencies, curl, vim, and unzip
RUN apt-get update && \
    apt-get install -y vim curl nginx gnupg2 apt-transport-https ca-certificates software-properties-common lsb-release unzip

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Install kubectl (latest)
RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Install Node.js (needed for Snyk CLI) and Snyk
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g snyk

# Clean default HTML and copy your landing page
RUN rm -rf /var/www/html/*
COPY HTMLCSS-LandingPage-master/ /var/www/html/

# Expose HTTP port
EXPOSE 80

# Start Nginx in foreground (needed for container to stay running)
CMD ["nginx", "-g", "daemon off;"]
