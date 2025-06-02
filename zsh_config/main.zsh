#!/usr/bin/env zsh

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"
PROJECT_ROOT="${SCRIPT_DIR:h}"

start_dev_container() {
    local original_dir=$(pwd)
    
    # Build the container
    echo "Building devcontainer..."
    docker build -t clodcontainer --build-arg TZ="${TZ:-America/Los_Angeles}" "${PROJECT_ROOT}/devcontainer"
    
    # Create volumes if they don't exist
    docker volume create claude-code-bashhistory >/dev/null 2>&1
    
    # Run the container
    echo "Starting devcontainer..."
    docker run -it \
        --cap-add=NET_ADMIN \
        --cap-add=NET_RAW \
        -v claude-code-bashhistory:/commandhistory \
        -v ~/.claude:/home/node/.claude \
        -v ~/Code/vibe_files/master/claude/commands:/home/node/.claude/commands \
        -v ~/.claude.json:/home/node/.claude.json \
        -v "${original_dir}:/workspace" \
        -e NODE_OPTIONS="--max-old-space-size=4096" \
        -e CLAUDE_CONFIG_DIR="/home/node/.claude" \
        -e POWERLEVEL9K_DISABLE_GITSTATUS="true" \
        -w /workspace \
        --user node \
        clodcontainer \
        bash -c "sudo /usr/local/bin/init-firewall.sh && /bin/zsh"
}