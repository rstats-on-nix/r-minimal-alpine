#! /usr/bin/env nix-shell
#! nix-shell default.nix -i bash 

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <image_name> <directory>"
    exit 1
fi

# Assign arguments to variables
image_name=$1
directory=$2

if [ -n "$WSL_INTEROP" ]; then
    echo "Running in WSL2"
    podman machine set --user-mode-networking
    podman machine init --user-mode-networking
    # https://github.com/containers/podman/issues/20921
fi


# Run podman build with the provided arguments
podman build --network host --dns 8.8.8.8 -t "${image_name}" "${directory}"
