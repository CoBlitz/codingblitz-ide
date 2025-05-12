# CodingBlitz IDE

A containerized VS Code environment for coding challenges and development, based on code-server. This container provides a web-based IDE with pre-installed support for Python and C/C++ development, allowing users to code in a browser without local setup.

## Features

- Web-based VS Code environment accessible from any browser
- Pre-installed support for Python and C/C++ development
- Git integration with automatic repository cloning
- Customizable environment through environment variables
- Runs as an unprivileged user for better security

## Quick Start

Run the container with default settings:

```bash
docker run -it --rm -p 8080:8080 ghcr.io/coblitz/codingblitz-ide:latest
```

Then access the IDE at http://localhost:8080

## Usage Examples

### Basic usage with custom project folder

```bash
docker run -it --rm \
  -e PROJECT_FOLDER=myproject \
  -p 8080:8080 \
  ghcr.io/coblitz/codingblitz-ide:latest
```

### Clone a Git repository on startup

```bash
docker run -it --rm \
  -e PROJECT_FOLDER=my-repo \
  -e GIT_REPO=https://github.com/username/repository.git \
  -p 8080:8080 \
  ghcr.io/coblitz/codingblitz-ide:latest
```

### Complete example with all options

```bash
docker run -it --rm \
  -e PROJECT_FOLDER=myapp \
  -e GIT_USER_NAME="Alice" \
  -e GIT_USER_EMAIL="alice@example.com" \
  -e GIT_REPO=https://github.com/username/repository.git \
  -p 4500:8080 \
  ghcr.io/coblitz/codingblitz-ide:latest
```

Then access the IDE at http://localhost:4500


## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PROJECT_FOLDER` | Name of the project folder | `project` |
| `GIT_REPO` | Git repository to clone on startup | None |
| `GIT_USER_NAME` | Git user name for config | `Coder User` |
| `GIT_USER_EMAIL` | Git user email for config | `coder@example.com` |

## Persistence

To persist your data across container restarts, mount a volume to the project directory:

```bash
docker run -it --rm \
  -v "$(pwd)/data:/home/coder/project" \
  -p 8080:8080 \
  ghcr.io/coblitz/codingblitz-ide:latest
```

## TODO

- [ ] Add LSP (Language Server Protocol) support for Python
  - [ ] Install and configure pylint or pyright
  - [ ] Add Python debugging extensions
  - [ ] Configure Python interpreter selection

- [ ] Add LSP support for C/C++
  - [ ] Install and configure clangd
  - [ ] Install extentions for C, also snippets

- [ ] General improvements
  - [ ] Add save script for easly pushing the working repository
  - [ ] Open a terminal window by default
  - [ ] Dark mode by default
  - [ ] Do not open the getting started page

## License

[MIT](LICENSE)
