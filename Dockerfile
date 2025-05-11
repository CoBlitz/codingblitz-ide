
FROM codercom/code-server:latest

# Switch to root to install system packages and manage ownership
USER root

# Install git, Python, and C/C++ toolchains
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    build-essential \
    gdb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Create project directory and give ownership to coder
RUN mkdir -p /home/coder/project && chown -R coder:coder /home/coder/project

# Copy entrypoint script to a safe location
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install VS Code extensions (can be run as root or coder)
RUN code-server --install-extension ms-python.python
# RUN code-server --install-extension ms-vscode.cpptools

# Set working directory
WORKDIR /home/coder/project

# Expose code-server port
EXPOSE 8080

# Use root to avoid permission issues at runtime
USER root

# Start the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
