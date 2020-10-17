{ config, pkgs, ... }:

{
  services.udev = {
    extraRules = ''
      ATTR{idVendor}=="0e8d", ATTR{idProduct}=="0003", ENV{ID_MM_DEVICE_IGNORE}="1"
      ATTR{idVendor}=="0e8d", ATTR{idProduct}=="0023", ENV{ID_MM_DEVICE_IGNORE}="1"
    '';
  };
}
