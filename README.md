# 🎯 Goal

This repo provisions a minimal nix-R container setup intended to run
efficient data science DevOps workflows.

- provision containers as remote builders for a nix store.
- provision containers for CI/CD environments, e.g. for data engineering
  purposes.

This is an experimental proof of concept to deliver a minimal alpine image 
provinding nix in a multiuser docker environment.

# 🌌 Background story

I've been reading a lot on the internet and I was surprised to find that what I
wanted seemed to be a  a patchwork of existing problems and solutions. Point out
to me if you think the ideas are stubborn or have security holes.

- Containers and Nix are a dream combo. 
- I wanted the official nix bash install script to install CppNix. First, 
  because the DetSys/Lix rust installer exits and does not like multiuser 
  docker installation out of the box.
- Alpine images are usually intended to provide instances 

# 🛠️ Implementation

- Create a container from a nix-shebang shell script that boostraps the docker
  build environment from a reproducibly pinned `default.nix`, proving `podman`
  and `qemu` (linux) or `vfkit` (macOS/darwin) virtualization.


# 🔀 Ways forward, backporting

Containers for runtimes such as Docker can also be built directly with Nix.

- `pkgs.dockerTools.buildImage` can make potentially smaller docker
  images. So yeah, the same `Dockerfile` can maybe just be injected into
  `podman run` using `result`. Say "hi" to declarative `docker.nix` files for
  cross-platform nix builds.

- For example, `buildLayeredImage` can be used to get caching based on layer 
  content.

# 🥗 Recipe

- Build the image on macOS

```sh
# nix-shebang script
./container_build.sh
```

## 📚 Varia, inspiration, links

- `vfkit` is packaged in nixpkgs. It is a command line tool to start VMs through
  the macOS Virtualization Framework. 
  [That's the packaging request](https://github.com/NixOS/nixpkgs/issues/306179),
  and [that's the PR adding it](https://github.com/NixOS/nixpkgs/pull/334907).
- [Short blog post by Robert Wachs](https://robert-wachs.com/posts/2024-06-20-podman-update-nix),
  which is a workaround to use impure `nix-shell` and `vfkit` installation from
  system to make `podman` work on macOS.

### Docker and Nix

- Blog by 
  [Mitchell Hashimot how on "Using Nix with Dockerfiles".](https://mitchellh.com/writing/nix-with-dockerfiles)
  Its a mature peace of text on how to build and ship applications using CI/CD 
  using containerised Nix setups. It illustrates how to resolve having a separate
  environment for local development, CI, and building the final Docker image for
  for production purposes. *"These problems all go away with Nix."

- [Nixery: an ad-hoc container image registry that provides packages from the Nix package manager.](https://nixery.dev/)

- [tazjin's blog: "Nixery: Improved Layering Design](https://tazj.in/blog/nixery-layers).
  Discusses layering strategies and algorithms that optimizes the layering
  strategy and minimixes caches.

- Discord: ["How to build a docker image with a working Nix inside it"](https://discourse.nixos.org/t/how-to-build-a-docker-image-with-a-working-nix-inside-it/32960)



- Discor

### Virtualization, containers and networking

-  Nested virtualization is used to run Hyper-V inside a Hyper-V virtual machine
   (VM). According to 
   [this Microsoft doc](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/nested-virtualization#configure-nested-virtualization), 
   this is e.g. useful for *"Running applications or emulators in a nested VM"*.
   Hey, that's our use case building nix derivations.

- Apparently only Windows 11 supports nested virtualization

- [RedHat blog *"How Podman runs on Macs and other container FAQs"*.](https://www.redhat.com/en/blog/podman-mac-machine-architecture)
  Deep dive that helped me to understand how the podman client is interacting
  with the VM, and how QEMU injection processes etc. work.

### Pinning mechanisms in Nix

- https://jade.fyi/blog/pinning-nixos-with-npins/

https://xeiaso.net/blog/i-was-wrong-about-nix-2020-02-10/

https://github.com/nmattia/niv

-> npins is successor: 
https://vaibhavsagar.com/blog/2018/05/27/quick-easy-nixpkgs-pinning/
https://jade.fyi/blog/pinning-packages-in-nix/
https://github.com/nix-community/docker-nixpkgs
https://nixery.dev/




-> https://github.com/cloudwatt/nix-container-images
https://github.com/LnL7/nix-docker -> makes sense




https://github.com/microsoft/WSL/issues/11216
-> no nested virtualization


    Running applications or emulators in a nested VM
    Testing software releases on VMs
    Reducing deployment times for training environments
    Using Hyper-V isolation for containers
