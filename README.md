# 🎯 Goal

This repo provisions a minimal nix-R container setup intended to run
efficient data science DevOps workflows.

This is an experimental proof of concept to deliver a minimal alpine image 
provinding nix in a multiuser docker environment

# 🌌 Background story

- Containers and Nix are a dream combo. 
- I wanted the official nix bash install script to install CppNix. First, 
  because the rust installer 

# 🛠️ Implementation

- Create a container from a nix-shebang shell script that boostraps the docker
  build environment from a reproducibly pinned `default.nix`, proving `podman`
  and `qemu` (linux) or `vfkit` (macOS/darwin) virtualization.

# 🔀 Ways forward

# 🥗 Recipe

- Build the image on macOS

```sh
# nix-shebang script
./container_build.sh
```

## 📚 Varia, inspiration, links

- `vfkit` is packaged in nixpkgs. It is a command line tool to start VMs through
  the macOS Virtualization Framework

https://github.com/NixOS/nixpkgs/issues/306179

https://github.com/NixOS/nixpkgs/pull/334907
https://robert-wachs.com/posts/2024-06-20-podman-update-nix
https://mitchellh.com/writing/nix-with-dockerfiles
https://xeiaso.net/blog/i-was-wrong-about-nix-2020-02-10/
https://github.com/nmattia/niv
-> npins is successor: https://jade.fyi/blog/pinning-nixos-with-npins/
https://vaibhavsagar.com/blog/2018/05/27/quick-easy-nixpkgs-pinning/
https://jade.fyi/blog/pinning-packages-in-nix/
https://github.com/nix-community/docker-nixpkgs
https://nixery.dev/
https://tazj.in/blog/nixery-layers
https://discourse.nixos.org/t/how-to-build-a-docker-image-with-a-working-nix-inside-it/32960/7
https://discourse.nixos.org/t/docker-image-build-with-nix-and-includes-nix-installed-in-multi-user-mode/593/9
-> https://github.com/cloudwatt/nix-container-images
https://github.com/LnL7/nix-docker -> makes sense
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/nested-virtualization#configure-nested-virtualization

 run Hyper-V inside a Hyper-V virtual machine (VM)

https://github.com/microsoft/WSL/issues/11216
-> no nested virtualization


    Running applications or emulators in a nested VM
    Testing software releases on VMs
    Reducing deployment times for training environments
    Using Hyper-V isolation for containers
