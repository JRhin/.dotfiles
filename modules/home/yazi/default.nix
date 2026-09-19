{ ... }:

{
  programs.yazi = {
    enable = true;

    # Shell wrapper: quitting yazi cd's your shell into the last directory
    enableZshIntegration = true;
  };
}
