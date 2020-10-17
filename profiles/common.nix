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
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    keyMap = "us";
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

  hardware.enableRedistributableFirmware = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  nix.gc.automatic = true;

  security.hideProcessInformation = true;

  nixpkgs.config.allowUnfree = true;
}
