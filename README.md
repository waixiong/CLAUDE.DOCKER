# Claude Code Docker

Ubuntu-based Docker container with Claude Code CLI pre-installed.

## Build the Image

```bash
cd CLAUDE.DOCKER
docker build -t claude-code .
```

## Run the Container

### Using the Run Script (Recommended)

The `run.sh` script handles workspace mounting with exclusions for `.env` and `data` by default:

```bash
# From project root (mounts current directory)
./CLAUDE.DOCKER/run.sh

# Mount a specific directory
./CLAUDE.DOCKER/run.sh /path/to/project

# Run claude directly
./CLAUDE.DOCKER/run.sh . claude

# Run with flags
./CLAUDE.DOCKER/run.sh . claude --dangerously-skip-permissions
```

To customize exclusions, edit the `EXCLUSIONS` array in `run.sh`.

### Manual Docker Run

Use `--mount type=tmpfs` to exclude files/folders (creates empty tmpfs overlay):

```bash
docker run -it --rm \
    -v "$(pwd)":/workspace \
    --mount type=tmpfs,destination=/workspace/.env \
    --mount type=tmpfs,destination=/workspace/data \
    -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
    claude-code
```

### Run a Single Command

```bash
docker run -it --rm \
    -v "$(pwd)":/workspace \
    --mount type=tmpfs,destination=/workspace/.env \
    --mount type=tmpfs,destination=/workspace/data \
    claude-code claude --help
```

### Run Claude Code Interactively

```bash
docker run -it --rm \
    -v "$(pwd)":/workspace \
    --mount type=tmpfs,destination=/workspace/.env \
    --mount type=tmpfs,destination=/workspace/data \
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
