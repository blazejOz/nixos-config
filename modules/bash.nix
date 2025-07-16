{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      gs = "git status";
      
    };
  
  };
}