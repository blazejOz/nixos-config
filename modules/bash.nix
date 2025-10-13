{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".."  = "cd ..";

      #git
      gs = "git status";

      #nixos
      flswitch = "sudo nixos-rebuild switch --flake ";
      
      #server_ip
      home_server = "ssh blaz@192.168.0.20";

      #Stop/start zerotier vpn tunnel
      stop_vpn = "sudo systemctl stop zerotierone.service";
      start_vpn = "sudo systemctl start zerotierone.service";
      
    };
  
  };
}