# https://github.com/toolbx-images/images/blob/c958db9d33647d04de76aa6afd0546ee198ba758/wolfi/latest/Containerfile
FROM cgr.dev/chainguard/wolfi-base:latest

ARG VERSION=latest
LABEL com.github.containers.toolbox="true" \
      org.opencontainers.image.url="ghcr.io/wilsonehusin/bench" \
      org.opencontainers.image.description="Personal development environment (toolbox / distrobox) based on Wolfi OS." \
      org.opencontainers.image.version=$VERSION

RUN --mount=type=bind,src=./packages,dst=/var/bench-packages,relabel=shared apk update \
 && apk upgrade \
 && cat /var/bench-packages/* | grep -v '^# ' | xargs apk add

# 1. Enable passwordless sudo.
#    using sudoers instead of toolbox filename here, so that in case of rootful
#    distroboxes, the NOPASSWD can be deactivated for security reasons.
# 2. Copy over os-release file.
# 3. Empty home and add /media (required by toolbx).
# 4. Link /usr/share/terminfo/{x,xterm-color} to avoid error on looking up xterm-256color.
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudoers \
 && cp -p /etc/os-release /usr/lib/os-release \
 && rm -r /home/* && mkdir /media \
 && ln -s /usr/share/terminfo/x /usr/share/terminfo/xterm-color
