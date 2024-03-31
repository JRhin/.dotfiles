{pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono";
    font.package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
    font.size = 12.0;
    theme = "Catppuccin-Mocha";
    settings = {
      background_opacity = "0.85";
    };
  };
}
