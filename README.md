# Homelab configs

## NixOS hosts

NixOS hosts are mostly automatically configurable, however some settings might need to be changed manually, which I hope I have listed exhaustively below:

- `nas-host-configuration.nix`
    - `fileSystems."/mnt/home-data".device` needs to be set to `/dev/disk/by-uuid/<DISK_UUID>`. Disk UUID can be found with `lsblk -f`

### Setup steps

- Install NixOS

    **NOTE**: After installing`/etc/nixos/configuration.nix` may contain the following lines:

    ```
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = false;
    ```

    If so, copy them into `/etc/nixos/hardware-configuration.nix` before proceeding.

- Clone/copy this repo into the host

- Symlink the desired `*-host-configuration.nix` to `/etc/nixos/configuration.nix`. For example,

    ```sh
    sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak \
    && sudo ln -s ~/homelab-configs/XYZ-host-configuration.nix /etc/nixos/configuration.nix
    ```

- Rebuild system
