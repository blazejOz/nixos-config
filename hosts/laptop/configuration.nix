{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
  networking.hostName = "laptop";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Hyprland
  programs.uwsm.enable = true;
  programs.hyprland ={
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11"; 
  
}
