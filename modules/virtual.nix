{ config, pkgs, lib, ... }:

{

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "blaz" ];

}