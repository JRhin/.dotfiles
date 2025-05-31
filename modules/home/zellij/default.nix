{...}:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      ui = {
        pane_frames = false;
        tab_bar = false;
        status_bar = false;
      };
      default_layout = "minimal";
    };
  };

  home.file.".config/zellij/layouts/minimal.kdl".text = ''
  layout {
    pane
  }
'';
}
