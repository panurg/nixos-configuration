{ config, pkgs, ... }:

{
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };
  hardware.bluetooth.enable = true;
  hardware.sensor.iio.enable = true;
  hardware.opengl.driSupport32Bit = true;

  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;
    # TODO: add Russian layout
    layout = "us";
    # imwheel.enable = true;
    # modules = [ pkgs.xf86_input_wacom ];
    # wacom.enable = true;
    # xautolock.enable = true;
    # Auto login in case of disk encryption
    # displayManager = {
    #   defaultSession = "none+i3";
    #   lightdm = {
    #     enable = true;
    #     autoLogin.enable = true;
    #     autoLogin.user = "alice";
    #   };
    # };
    displayManager = {
      gdm = {
        enable = true;
        # TODO: investigate wayland
        wayland = false;
      };
    };
    desktopManager.gnome3.enable = true;
    libinput.enable = true;
  };

  # Fix for Home Manager error
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

  services.tlp.enable = true;

  services.fstrim.enable = true;

  services.thermald.enable = true;

  powerManagement.powertop.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      corefonts
    ];
  };
}
