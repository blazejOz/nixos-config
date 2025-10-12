{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    brightnessctl
    wireguard-tools
  ];

  #wireguard client setup for proxmox
  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.8.0.2/24" ];
    privateKeyFile = "/etc/wireguard/client_private.key";
    peers = [{
      publicKey = "PCqo8T3xMqlQ/VVxiYaG8J/Db/4UeT8s2pHn87L20So=";
      allowedIPs = [ "192.168.0.0/24" "10.8.0.0/24" ];
      endpoint = "89.78.139.252:51820";
      persistentKeepalive = 25;
    }];
  };

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
