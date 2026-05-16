# Silverblue
FROM ghcr.io/ublue-os/kinoite-main

# Install NVIDIA drivers
COPY --from=ghcr.io/ublue-os/akmods-nvidia-open:main-44 / /tmp/akmods-nvidia
RUN find /tmp/akmods-nvidia
RUN dnf -y remove --no-autoremove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra
RUN rpm-ostree install /tmp/akmods-nvidia/rpms/kmods/kmod-nvidia-7.0.8-200.fc44.x86_64-595.71.05-1.fc44.x86_64.rpm
RUN rpm-ostree install /tmp/akmods-nvidia/rpms/nvidia/nvidia-driver-cuda-595.71.05-1.fc44.x86_64.rpm
RUN rpm-ostree install /tmp/akmods-nvidia/rpms/nvidia/xorg-x11-nvidia-595.71.05-1.fc44.x86_64.rpm

# Linting
RUN bootc container lint
