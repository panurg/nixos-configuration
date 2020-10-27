{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 8080 ];
  services.xserver = {
    enable = true;
    desktopManager.kodi.enable = true;
    displayManager.lightdm.autoLogin = {
      enable = true;
      user = "tv";
    };
  };
}
