{ config, pkgs, lib, ... }:

{

  networking.hostName = "desktop";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  #AMD GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # disable wakeup 
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

  #  # Hyprland
  #  programs.uwsm.enable = true;
  #  programs.hyprland ={
  #    enable = true;
  #    withUWSM = true;
  #    xwayland.enable = true;
  #  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [ "gtk" ];
      };
      # hyprland = {
      #   default = [ "hyprland" "gtk" ];
      #   # FORCE ScreenCast to use Hyprland
      #   "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
      #   "org.freedesktop.impl.portal.Screenshot" = "hyprland";
      # };
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11"; 
  
}
