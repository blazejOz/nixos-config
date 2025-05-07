{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/gaming.nix
      ../../modules/common.nix
      ../../modules/devtools.nix

    ];
  
  systemd.packages = with pkgs; [ 
    
  ];

  networking.hostName = "desktop";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  #AMD GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
   boot.kernelParams = ["amdgpu.noretry=0"];
  # services.xserver.enable = false;
  # services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.enableRedistributableFirmware = true;
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow building the broken-in-nixpkgs driver:
  nixpkgs.config.allowBroken = true;

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

#  systemd.services."systemd-suspend.service".serviceConfig.Environment = lib.mkForce [
#    "SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"  # ← keeps Hyprland’s socket alive :contentReference[oaicite:3]{index=3}
#  ];
  

  # Enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11"; 
  
}
