{pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    font.name = "FireCode Nerd Font Mono";
    font.package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
    font.size = 12.0;
    theme = "Catppuccin-Mocha";
  };
}
