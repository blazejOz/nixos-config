{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/gaming.nix
      ../../modules/nvidia.nix
      ../../modules/common.nix
    ];
  
  networking.hostName = "desktop";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow building the broken-in-nixpkgs driver:
  nixpkgs.config.allowBroken = true;

  # Ethernet module for motherboard
  boot.extraModulePackages = [
    pkgs.linuxKernel.packages.linux_6_6.r8125
  ];
  
  #disable wakeup 
  systemd.services.disable-wakeups = {
    description = "Disable all wakeup sources except power button";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ]; # optional
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "disable-wakeups" ''
        for f in /sys/bus/*/devices/*/power/wakeup; do
          echo "disabled" > "$f"
        done
      '';
    };
  };

  # Hyprland
  programs.uwsm.enable = true;
  programs.hyprland ={
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  systemd.services."systemd-suspend.service".serviceConfig.Environment = lib.mkForce [
    "SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"         # ← keeps Hyprland’s socket alive :contentReference[oaicite:3]{index=3}
  ];
  

  # Enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11"; 
  
}
