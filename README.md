# nixos-configuration
NixOS configuration repo

# Installation
1. Boot from NixOS ISO
1. For HiDPI monitor setup biggest font: `setfont LatGrkCyr-12x22`
1. There should be an internet connection. For WiFi use wpa_supplicant from the root: `wpa_supplicant -B -i interface -c <(wpa_passphrase 'SSID' 'key')`
1. Prepare filesystems and mount all of them to the /mnt. Example in the official manual: https://nixos.org/nixos/manual/index.html#sec-installation
1. Install git: `nix-env -i -A nixos.pkgs.git`
1. Clone this repository to the /mnt/etc/nixos: `git clone https://github.com/panurg/nixos-configuration /mnt/etc/nixos`
1. Generate NixOS config: `nixos-generate-config --root /mnt`
1. Move generated configuration to the machines direcoty, create symlinks and make some edits - TBD
1. Add the appropriate Home Manager channel: `nix-channel --add https://github.com/rycee/home-manager/archive/release-20.03.tar.gz home-manager && nix-channel --update`
1. Install: `nixos-install`
1. If everything is ok - `reboot`
