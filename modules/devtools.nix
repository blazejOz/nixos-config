{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    pgadmin4
    (python3.withPackages (ps: with ps; [ requests ]))
    
  ];
  
}


