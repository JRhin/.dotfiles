{inputs, ...}:

{
  programs.firefox = {
    enable = true;

    profiles.jrhin = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux";[
        adblocker-ultimate
        multi-account-containers
        proton-pass
        proton-vpn
      ];
    };
  };
}
