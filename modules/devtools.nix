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

    #java
    jdk
    maven

    #VS code
    vscode

    #bash
    bc
    
  ];
  
}


