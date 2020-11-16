{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 8080 9091 ];
  services.xserver = {
    enable = true;
    desktopManager.kodi.enable = true;
    displayManager.autoLogin = {
      enable = true;
      user = "tv";
    };
  };
  services.transmission = {
    enable = true;
    openFirewall = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,::1,192.168.1.*";
      rpc-host-whitelist = config.networking.hostName;
      incomplete-dir-enabled = false;
      download-dir = "${config.users.users.tv.home}/dl";
      ratio-limit = 3;
      ratio-limit-enabled = true;
    };
  };
}
