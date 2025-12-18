{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [

    #python:
    (python3.withPackages (ps: with ps; [ requests matplotlib reportlab sympy numpy pandas]))

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

    #raylib
    raylib

    #java
    jdk
    maven

    #VS code
    vscode

    #bash
    bc
    
    #simulation
    scilab-bin
  ];
  
  programs.direnv.enable = true;

}


