# Silverblue
FROM ghcr.io/wayblueorg/sway-nvidia-gdm:43

# Kernel arguments
RUN mkdir -p /usr/lib/bootc/kargs.d
RUN cat <<EOF >> /usr/lib/bootc/kargs.d/00-nvidia.toml
kargs = [
  "rd.driver.blacklist=nouveau",
  "modprobe.blacklist=nouveau",
  "nvidia-drm.modeset=1",
  "nvidia-drm.fbdev=1",
  "rhgb",
  "quiet",
  "root=UUID=cf118247-a944-4c2e-beb6-bfcdf41e4590",
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

# RPMs
COPY repos/scottames-ghostty-fedora-44.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo
RUN dnf -y install ghostty tmux vim zsh

# Linting
RUN bootc container lint
