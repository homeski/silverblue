# Silverblue
FROM ghcr.io/ublue-os/kinoite-main

# Install NVIDIA drivers
COPY --from=ghcr.io/ublue-os/akmods-nvidia-open:main-44 / /tmp/akmods-nvidia
RUN find /tmp/akmods-nvidia
RUN dnf -y remove --no-autoremove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra
RUN rpm-ostree install /tmp/akmods-nvidia/rpms/kmods/kmod-nvidia-7.0.8-200.fc44.x86_64-595.71.05-1.fc44.x86_64.rpm
RUN rpm-ostree install /tmp/akmods-nvidia/rpms/nvidia/nvidia-driver-cuda-595.71.05-1.fc44.x86_64.rpm
RUN rpm-ostree install /tmp/akmods-nvidia/rpms/nvidia/xorg-x11-nvidia-595.71.05-1.fc44.x86_64.rpm

# Kernel arguments
RUN mkdir -p /usr/lib/bootc/kargs.d
RUN cat <<EOF >> /usr/lib/bootc/kargs.d/00-nvidia.toml
kargs = [
  "rd.driver.blacklist=nouveau,nova_core",
  "modprobe.blacklist=nouveau,nova_core",
  "rhgb",
  "quiet",
  "root=UUID=e042907b-dfa6-4fee-b2d5-3be38e7ced8c",
  "vconsole.keymap=us",
  "rootflags=subvol=root",
  "rw"
]
EOF

# Disable RAOP sound devices
RUN mkdir -p /etc/pipewire/pipewire.conf.d/
RUN cat <<EOF >> /etc/pipewire/pipewire.conf.d/disable-raop.conf
context.properties = {
  module.raop = false
}
EOF

# Linting
RUN bootc container lint
