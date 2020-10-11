# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    <home-manager/nixos>
    ../profiles/common.nix
    ../profiles/wowcube.nix
    ../profiles/laptop.nix
    ../users/panurg.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ "dm-snapshot" "i915" ];
      luks.devices = {
        tank = {
          allowDiscards = true;
          device = "/dev/disk/by-uuid/f15b264a-b675-42c3-b240-da9e51db7139";
          fallbackToPassword = true;
        };
      };
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    loader = {
      efi = {
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        enableCryptodisk = true;
      };
    };

    kernelParams = [
      "i915.enable_fbc=1"
      # "i915.enable_psr=2"
    ];

    blacklistedKernelModules = [ "psmouse" ];

    kernel.sysctl = {
      "vm.swappiness" = 1;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/78f0b518-e252-418a-9520-dfaec58244db";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/b27db1cb-405d-4ac4-bb4a-e36343a7d4af";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };

    "/boot/efi" = {
      device = "/dev/disk/by-uuid/321B-8DA8";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/cc822852-560d-4ccb-9487-794ee9e40c93"; }
  ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  hardware.cpu.intel.updateMicrocode =
    config.hardware.enableRedistributableFirmware;

  networking = {
    hostName = "hal9000"; # Define your hostname.
    nat.externalInterface = "wlp60s0";
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware.opengl.extraPackages = with pkgs; [
    # vaapiIntel
    # vaapiVdpau
    # libvdpau-va-gl
    intel-media-driver
  ];

  services.xserver.videoDrivers = [ "intel" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
