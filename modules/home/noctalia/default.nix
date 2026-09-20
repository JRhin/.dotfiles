{ inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    # Run the shell as a systemd user service
    systemd.enable = true;

    settings = {
      # The official and community plugin sources are built in
      plugins.enabled = [
        "noctalia/bongocat"
        "dotnetrob/cat"
        "lucasoe/proton-pass"
      ];

      # Bar widgets provided by plugins: type = "<author>/<plugin>:<entry>"
      widget = {
        bongocat.type = "noctalia/bongocat:cat";
        runningcat.type = "dotnetrob/cat:cat";
      };

      # Main bar on the left (vertical: start = top, center = middle, end = bottom)
      bar.default = {
        position = "left";
        start = [ "launcher" "wallpaper" "workspaces" ];
        center = [ "clock" ];
        end = [
          "bongocat" "runningcat"
          "media" "tray" "notifications" "clipboard" "network" "bluetooth"
          "volume" "brightness" "battery" "control-center" "session"
        ];
      };

      desktop_widgets =
        let
          # One spectrum widget per output: name and LOGICAL size from `niri msg outputs`
          visualizer = output: w: h:
            let
              boxHeight = h * 0.45;   # bars reach about 45% of the screen height
            in
            {
              type = "audio_visualizer";
              inherit output;
              cx = w / 2.0;
              cy = h - boxHeight / 2.0;
              box_width = w * 1.0;
              box_height = boxHeight;
              rotation = 0.0;

              settings = {
                background = false;
                bands = builtins.floor (w / 48.0);   # mirrored doubles it: about one bar every 24 px
                mirrored = true;                     # symmetric around the middle of the screen
                reversed = false;                    # true = treble in the middle, bass at the edges
                centered = false;
                show_when_idle = false;
                color_1 = "primary";
                color_2 = "primary";
              };
            };
        in
        {
          enabled = true;
          schema_version = 2;
          widget_order = [ "audio_1" "audio_2" ];

          widget.audio_1 = visualizer "eDP-1" 1536 864;
          widget.audio_2 = visualizer "HDMI-A-1" 3440 1440;
        };
    };
  };
}
