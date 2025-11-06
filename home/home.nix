{ config, pkgs, ... }:

{

  imports = [
    ../modules/hyprland/default.nix
    ../modules/neovim/default.nix
    ../modules/bash.nix
  ];


  home.username = "blaz";
  home.homeDirectory = "/home/blaz";
  
  programs.git = {
    enable = true;
    settings.user = {
      name  = "blazejOz";
      email = "blazej.ozog@gmail.com";
    };
  };

  home.packages = with pkgs; [
	  vlc
	  qbittorrent
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
