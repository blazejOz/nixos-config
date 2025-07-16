{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ..  = "cd ..";

      #git
      gs = "git status";

      #nixos
      flswitch = "sudo nixos-rebuild switch --flake ";
      
      
    };
  
  };
}