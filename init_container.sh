#! /usr/bin/env nix-shell
#! nix-shell default.nix -i bash  
# Check if both arguments are provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <image_name>"
    exit 1
fi

# Assign arguments to variables
image_name=$1
directory=$2

# Run podman build with the provided arguments
container_id =$(podman create $"image_name")

if [ $? -eq 0 ]; then
    # Print the container ID
    echo "${container_id}"
else
    echo "Error initial container from image ${image_name}"
    exit 1
fi
