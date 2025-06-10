{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    #postgreSQL
    postgresql
    pgadmin4

    #python:
    (python3.withPackages (ps: with ps; [ requests matplotlib reportlab]))

    gcc
    gdb
    nasm
    
  ];
  
services.postgresql = {
    enable  = true;
    package = pkgs.postgresql_15;

    authentication = ''
      local   all   all   peer
    '';
  };

}


