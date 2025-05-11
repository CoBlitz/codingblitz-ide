#!/bin/bash
set -e

# Ensure project folder exists and is owned by coder
mkdir -p /home/coder/project
chown -R coder:coder /home/coder/project

# If GIT_REPO is defined, and .git is missing, clone into project
if [ ! -z "$GIT_REPO" ] && [ ! -d "/home/coder/project/.git" ]; then
  echo "Cloning repository $GIT_REPO..."
  git clone "$GIT_REPO" /home/coder/project
  chown -R coder:coder /home/coder/project
fi

# Start code-server as the coder user (recommended even if container is root)
exec su coder -c "code-server --bind-addr 0.0.0.0:8080 --auth none /home/coder/project"

