{ config, pkgs, ... }:

{
  # NTFS for Windows flash drives
  boot.supportedFilesystems = [ "ntfs" ];

  # Some common networking settings
  networking = {
    useDHCP = false;
    networkmanager.enable = true;
    # TODO: check its options
    # Prevent nm to manage container interfaces
    networkmanager.unmanaged = [ "interface-name:ve-*" ];
    # Configure NAT for containers
    nat.enable = false;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    keyMap = "us";
    earlySetup = true;
  };

  time.timeZone = "Europe/Moscow";

  environment = {
    systemPackages = with pkgs; [
      vim git
    ];

    shells = [ pkgs.zsh ];

    variables = {
      EDITOR = "vim";
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  services.smartd.enable = true;
  services.fstrim.enable = true;

  hardware.enableRedistributableFirmware = true;

  system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  nix.gc.automatic = true;

  security.hideProcessInformation = true;

  nixpkgs.config.allowUnfree = true;
}
