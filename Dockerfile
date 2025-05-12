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

# Install VS Code extensions (run as coder)
USER coder
WORKDIR /home/coder
RUN code-server --install-extension ms-python.python


# Copy entrypoint script to a safe location
USER root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose code-server port
EXPOSE 8080

# Start the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
