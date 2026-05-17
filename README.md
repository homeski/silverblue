```sh
# Show deployments
rpm-ostree status

# Delete deployment
ostree admin undeploy 0

# Unpin deployment
ostree admin pin --unpin <id>

# Create deployment from local Podman image
bootc switch --transport=containers-storage localhost/<name>:<tag>

# Create fresh deployment from loaded image
# Resets /etc and /var to empty
bootc install reset --experimental --no-root-kargs

# Show kernel arguments for deployments
cat /boot/loader/entries/ostree-<id>.conf

# Clean up existing stateroot if getting errors
mount -o remount,rw /sysroot
rm -rf /sysroot/ostree/deploy/<name>
```
