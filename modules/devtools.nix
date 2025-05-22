{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    #postgreSQL
    postgresql
    pgadmin4

    #python:
    (python3.withPackages (ps: with ps; [ requests matplotlib]))
    
  ];
  
}


