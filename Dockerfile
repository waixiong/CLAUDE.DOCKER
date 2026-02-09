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

# Create non-root user 'claude'
RUN useradd -m -s /bin/bash claude

# Install Claude Code CLI as the claude user (native installation)
USER claude
RUN curl -fsSL https://claude.ai/install.sh | bash
USER root

# Ensure claude binary is in PATH for all shell types
ENV PATH="/home/claude/.local/bin:${PATH}"

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
