#!/bin/bash
set -e

# Environment variables with defaults
: ${PROJECT_FOLDER:=project}
: ${GIT_USER_NAME:=Coder User}
: ${GIT_USER_EMAIL:=coder@example.com}

# Ensure project folder exists and is owned by coder
mkdir -p /home/coder/"$PROJECT_FOLDER"
chown -R coder:coder /home/coder/"$PROJECT_FOLDER"

# If GIT_REPO is defined, and .git is missing, clone into project
if [ ! -z "$GIT_REPO" ] && [ ! -d "/home/coder/"$PROJECT_FOLDER"/.git" ]; then
  echo "Cloning repository $GIT_REPO..."
  git clone "$GIT_REPO" /home/coder/"$PROJECT_FOLDER"
  chown -R coder:coder /home/coder/"$PROJECT_FOLDER"
fi

# Start code-server as the coder user (recommended even if container is root)
exec su coder -c "export PROJECT_FOLDER=${PROJECT_FOLDER}; code-server --bind-addr 0.0.0.0:8080 --auth none /home/coder/\$PROJECT_FOLDER"
