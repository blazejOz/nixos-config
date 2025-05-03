{ config, pkgs, ... }:

{
  
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # optional: allows Steam Remote Play
    dedicatedServer.openFirewall = true; # optional: allows hosting servers
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
    protonup-qt
  ];
  
}

