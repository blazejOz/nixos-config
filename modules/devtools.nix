{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    #postgreSQL
    postgresql
    pgadmin4

    #python:
    (python3.withPackages (ps: with ps; [ requests matplotlib reportlab sympy numpy]))

    #rust
    rustc
    cargo

    #c/c++
    cmake
    gnumake
    ncurses
    gcc
    gdb
    nasm

    #java
    jdk

    #HDL
    iverilog
    gtkwave

    #VS code
    vscode
    
  ];
  
  services.postgresql = {
      enable  = true;
      package = pkgs.postgresql_15;

      authentication = ''
        local   all   all   peer
      '';
    };

}


