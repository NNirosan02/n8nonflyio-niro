FROM node:20-bookworm-slim

# pass N8N_VERSION Argument while building or use default
ARG N8N_VERSION=1.39.1

# Update everything and install needed dependencies using apt
RUN apt-get update && apt-get install -y \
    graphicsmagick \
    tzdata \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set a custom user to not have n8n run as root
USER root

# Install n8n globally
# We include build-essential (Debian's equivalent to build-base) above
RUN npm_config_user=root npm install --location=global n8n@${N8N_VERSION}

# Specifying work directory
WORKDIR /data

# define execution entrypoint
CMD ["n8n"]
