{inputs, ...}:

{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";

    profiles.jrhin = {
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux";[
        adblocker-ultimate
        multi-account-containers
        proton-pass
        proton-vpn
      ];
    };
  };
}
