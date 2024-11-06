FROM alpine:3.20.3

# Add DNS configuration
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf && \
    echo "nameserver 8.8.4.4" >> /etc/resolv.conf

RUN apk update && \
    apk add --no-cache \
        bash \
        curl \
        sudo \
        shadow \
        xz \
        openrc && \
        mkdir -p /run/openrc && \
        touch /run/openrc/softlevel

# Set environment variables
ENV NIX_FIRST_BUILD_UID=1000
ENV NIX_BUILD_GROUP_ID=101

RUN mkdir -m 0755 /nix && \
    chown root /nix && \
    addgroup -S nixbld && \
    for n in $(seq 1 10); do \
        adduser -D -H -g "Nix build user $n" \
            -G nixbld -s "$(command -v nologin)" "nixbld$n"; \
    done

# Install Nix
RUN sh <(curl -L https://nixos.org/nix/install) \
    --daemon --yes

RUN echo 'extra-experimental-features = flakes nix-command' >> /etc/nix/nix.conf

# nix rc service script
COPY nix-daemon.sh /etc/init.d/nix-daemon
# Make the script executable
RUN chmod a+rx /etc/init.d/nix-daemon && \
    cp /root/.nix-profile/bin/nix-daemon /usr/sbin # && \
    rc-update add nix-daemon

WORKDIR /app
COPY . /app

VOLUME [ "/sys/fs/cgroup" ]

# Alpine docker images allow only a single process to be launched
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

CMD ["nix-shell", "/app/"]
