FROM ubuntu:24.04

LABEL maintainer="Buildex Claude"
LABEL description="Ubuntu container with Claude Code CLI"

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI globally
RUN npm install -g @anthropic-ai/claude-code

# Create non-root user 'claude'
RUN useradd -m -s /bin/bash claude

# Create workspace directory and set ownership
RUN mkdir -p /workspace && chown -R claude:claude /workspace

# Switch to non-root user
USER claude

# Set working directory
WORKDIR /workspace

# Volume will be mounted at runtime (excluding .env and CLAUDE.DOCKER)
VOLUME ["/workspace"]

# Default command
CMD ["bash"]
