#! /usr/bin/env nix-shell
#! nix-shell -i bash -p podman vfkit
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/30c9efeef01e2ad4880bff6a01a61dd99536b3c9.tar.gz
podman build --network host --dns 8.8.8.8 -t nix-alpine .
podman run --privileged --rm -it nix-alpine # /bin/sh
