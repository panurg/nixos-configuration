# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    <home-manager/nixos>
    ../profiles/common.nix
    ../profiles/htpc.nix
    ../profiles/home-manager.nix
    ../users/panurg-base.nix
    ../users/tv.nix
  ];

  boot = {
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "sd_mod" ];
    # TODO: check if coretemp is needed
    kernelModules = [ "kvm-intel" "coretemp" "i915" ];

    loader = {
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
      grub = {
        efiSupport = true;
        device = "nodev";
      };
    };

    kernelParams = [
      "zfs.zfs_arc_max=15032385536"
      "i915.enable_fbc=1"
      "i915.enable_guc=2"
    ];

    blacklistedKernelModules = [ "psmouse" ];

    kernel.sysctl = {
      "vm.swappiness" = 1;
    };

    supportedFilesystems = [ "zfs" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e03966ed-52bb-448f-9034-fd4baca60dec";
      fsType = "ext4";
    };

    "/boot/efi" = {
      device = "/dev/disk/by-uuid/62B1-9535";
      fsType = "vfat";
    };

    "/home" = {
      device = "tank/home";
      fsType = "zfs";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/114610ff-09df-406c-82aa-2f0c7740a6b7"; }
  ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  networking = {
    hostName = "joshua";
    hostId = "fc50d667";
  };

  hardware.cpu.intel.updateMicrocode =
    config.hardware.enableRedistributableFirmware;

  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
  };

  services.xserver.videoDrivers = [ "intel" ];

  sound = {
    enable = true;
    extraConfig = ''
      defaults.pcm.card 0
      defaults.pcm.device 3
      defaults.ctl.card 0
    '';
  };
}

