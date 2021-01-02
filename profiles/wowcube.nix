{ config, pkgs, ... }:

{
  networking = {
    nat.internalInterfaces = [ "ve-wowcube" ];
  };

  services.udev = {
    extraRules = ''
      ATTR{idVendor}=="0e8d", ATTR{idProduct}=="0003", ENV{ID_MM_DEVICE_IGNORE}="1"
      ATTR{idVendor}=="0e8d", ATTR{idProduct}=="0023", ENV{ID_MM_DEVICE_IGNORE}="1"
    '';
  };

  containers = {
    wowcube = with config.users.users.panurg; {
      allowedDevices = [
        { modifier = "rw"; node = "char-ttyACM"; }
      ];
      autoStart = true;
      privateNetwork = true;
      hostAddress = "10.0.0.0";
      localAddress = "10.0.0.1";
      bindMounts = {
        "${home}/src/CubiosV2" = {
          hostPath = "${home}/src/CubiosV2";
          isReadOnly = false;
        };
        "${home}/src/ResourcesV2" = {
          hostPath = "${home}/src/ResourcesV2";
          isReadOnly = false;
        };
      };
      bindMounts."/dev_host" = {
        hostPath = "/dev";
        isReadOnly = false;
      };
      config = {config, pkgs, ...}:
      {
        environment.systemPackages = with pkgs; let
          pawn = callPackage ../packages/pawn.nix {};
        in [
          winePackages.stable
          winePackages.fonts
          winetricks
          minicom
          (python2.withPackages (ps: with ps; [ intelhex pillow pyserial ]))
          nodejs
          pawn
          gnumake
          lsof
        ];
        environment.variables = {
          TERM="xterm";
        };
        services.openssh = {
          enable = true;
          forwardX11 = true;
          passwordAuthentication = false;
        };
        users.users.${name} = {
          isNormalUser = true;
          openssh.authorizedKeys.keyFiles = [ "${home}/.ssh/id_rsa.pub" ];
          extraGroups = [ "dialout" ];
        };
      };
    };
  };
}
