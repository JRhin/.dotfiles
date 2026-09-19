{ pkgs, ... }:

{
  programs.niri.enable = true;

  # X11 apps under niri: niri starts it on demand when it is in PATH
  environment.systemPackages = [ pkgs.xwayland-satellite ];

  # Run Electron/Chromium apps (Discord, Obsidian, ...) natively on Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
