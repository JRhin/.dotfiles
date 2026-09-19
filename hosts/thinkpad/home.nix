{ pkgs, ... }:

let
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  stateVersion = "26.05"; # Please read the comment before changing.
  
  browser = "zen";
  br_profile = "jrhin";
  editor = "hx";
  shell = "zsh";
  terminal = "kitty";
  username = "jrhin";
in {
  home.stateVersion = stateVersion; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home/bottom
    ../../modules/home/browser/${browser}
    ../../modules/home/browser/firefox
    ../../modules/home/btop
    ../../modules/home/cava
    ../../modules/home/fzf
    ../../modules/home/editors/${editor}
    ../../modules/home/git
    ../../modules/home/gitui
    ../../modules/home/niri
    ../../modules/home/noctalia
    ../../modules/home/shells/${shell}
    ../../modules/home/spicetify
    ../../modules/home/swaylock
    ../../modules/home/terminals/${terminal}
    ../../modules/home/yazi
    ../../modules/home/zellij
    ../../modules/home/zoxide
  ];

  home.username = username;
  home.homeDirectory = "/home/"+username;
  
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home.packages = with pkgs; [
    cbonsai
    discord
    dust
    obsidian
    telegram-desktop
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = editor;
    SHELL = shell;
    TERMINAL = terminal;
  };

  stylix.targets.firefox.profileNames = [ br_profile ];
  stylix.targets.zen-browser.profileNames = [ br_profile ];
}
