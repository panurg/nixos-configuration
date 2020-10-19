{ config, pkgs, ... }:

{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
