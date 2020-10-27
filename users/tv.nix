{ config, pkgs, ... }:

{
  users.users.tv = {
    description = "TV user";
    isNormalUser = true;
    extraGroups = [ "audio" "video" ];
  };
}
