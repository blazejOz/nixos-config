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
      server_ip = 192.168.0.20
      
    };
  
  };
}