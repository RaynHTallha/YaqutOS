FROM scratch AS ctx
COPY build_files /


# Base Image
FROM ghcr.io/ublue-os/bazzite-gnome-nvidia-open:stable as YaqutOS

# Run the main build and setup scripts, utilizing bind mounts for source files
# and various caching/tmpfs mounts for optimized build performance.
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
## Any added bash script that should run during build should be bellow
    /ctx/build.sh &&    \
    /ctx/wm.sh

## Copy hyprland config files to new users
COPY configs/hypr /etc/skel/.config/hypr

## Verify final image and contents are correct.
RUN bootc container lint
