{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/common.nix
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

  # systemd.services."systemd-suspend.service".serviceConfig.Environment = lib.mkForce [
  #   "SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"  # ← keeps Hyprland’s socket alive :contentReference[oaicite:3]{index=3}
  # ];
  

  # Enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11"; 
  
}
