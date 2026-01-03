{ config, pkgs, ... }:
{
  services.xserver.enable = true; # optional
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm.settings.General.DisplayServer = "wayland";


}
