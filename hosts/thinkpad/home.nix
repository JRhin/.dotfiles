{ config, pkgs, ... }:

let
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  stateVersion = "23.11"; # Please read the comment before changing.
  
  editor = "hx";
  terminal = "kitty";
  username = "jrhin";
in {
  home.stateVersion = stateVersion; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home/git
    ../../modules/home/editors/${editor}
    ../../modules/home/terminals/${terminal}
  ];

  home.username = username;
  home.homeDirectory = "/home/"+username;
  
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home.packages = with pkgs; [
    anki
    bottom
    cava
    discord
    firefox
    gh
    gitui
    htop
    obsidian
    telegram-desktop
    zellij
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = editor;
    TERMINAL = terminal;
  };
}