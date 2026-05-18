# Silverblue
FROM ghcr.io/ublue-os/kinoite-nvidia:latest

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
