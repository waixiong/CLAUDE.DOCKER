# Claude Code Docker

Ubuntu-based Docker container with Claude Code CLI pre-installed.

## Build the Image

```bash
cd CLAUDE.DOCKER
docker build -t claude-code .
```

## Run the Container

### Interactive Shell

Mount the project directory (excluding .env, data, or any sensitive paths):

```bash
# From project root
docker run -it --rm \
    -v "$(pwd)":/workspace \
    -v /workspace/.env \
    -v /workspace/data \
    claude-code
```

The `-v /workspace/.env` and `-v /workspace/data` flags create anonymous volumes that shadow those paths, effectively excluding them from the bind mount.

### Run a Single Command

```bash
docker run -it --rm \
    -v "$(pwd)":/workspace \
    -v /workspace/.env \
    -v /workspace/data \
    claude-code claude --help
```

### Run Claude Code Interactively

```bash
docker run -it --rm \
    -v "$(pwd)":/workspace \
    -v /workspace/.env \
    -v /workspace/data \
    -e ANTHROPIC_API_KEY="your-api-key" \
    claude-code claude
```

## Environment Variables

Pass your API key via environment variable:

```bash
docker run -it --rm \
    -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
    -v "$(pwd)":/workspace \
    claude-code claude
```

## Execute Commands in Running Container

If you have a running container, exec into it:

```bash
# Find container ID
docker ps

# Exec into container
docker exec -it <container_id> bash

# Or run claude directly
docker exec -it <container_id> claude
```

## Cleanup

Remove old images using the provided script:

```bash
./CLAUDE.DOCKER/cleanup.sh
```
