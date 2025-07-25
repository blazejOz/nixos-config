{ config, pkgs, ... }:

{

  home.packages = with pkgs; [

    #cursor theme
    adwaita-icon-theme
    
    #Hyprland
    waybar
    hyprpaper
    hyprpolkitagent
    mako
    libnotify
    bluetui
    grim
    slurp
    wl-clipboard
    rofi
    nautilus
    pulsemixer 

  ];

  gtk.cursorTheme = {
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };


  ##### Hyprland 
  xdg.configFile."hypr".source = ./hypr;


  ##### Waybar
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."waybar/toggle-charge.sh" = {
    source = ./waybar/toggle-charge.sh;
    executable = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = "0";
    };
  };





}
