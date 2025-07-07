{ config, pkgs, ... }:

{

  imports = [
    ./hyprland/default.nix
    ./neovim/default.nix
    #./bash/bash.nix
  ];


  home.username = "blaz";
  home.homeDirectory = "/home/blaz";
  
  #programs.vscode.enable = true;

  programs.git = {
    enable = true;
    userName  = "blazejOz";
    userEmail = "blazej.ozog@gmail.com";
  };

  home.packages = with pkgs; [
	  vlc
	  qbittorrent
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
