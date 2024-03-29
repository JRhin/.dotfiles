{ inputs, config, pkgs, ... }:

let
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  stateVersion = "23.11"; # Did you read the comment?

  bootMode = "uefi";
  defaultLocale = "en_US.UTF-8";
  locale = "it_IT.UTF-8";
  timeZone = "Europe/Rome";
in {
  
  imports = [
      # Include the results of the hardware scan.
      ../../hardware/thinkpad/hardware-configuration.nix

      ../../modules/system/nvidia
      ../../modules/system/pipewire
      ../../modules/system/printing
      inputs.home-manager.nixosModules.default
  ];
  
  # StateVersion
  system.stateVersion = stateVersion;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Boot Settings
  boot = {
    initrd.secrets = {    
      "/crypto_keyfile.bin" = null;
    };

    # Boot Loader
    loader = {
      # Grub
      grub.enable = if (bootMode == "grub") then true else false;

      # Uefi
      efi.canTouchEfiVariables = if (bootMode == "uefi") then true else false;
      systemd-boot = {
        enable = if (bootMode == "uefi") then true else false;
        configurationLimit = 10;
      };
    };
  };

  # Garbage Collect
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };



  #------------------------------------------------------------
  #
  #                       USERS SETTINGS
  #
  #------------------------------------------------------------
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    jrhin = {
      isNormalUser = true;
      description = "jrhin";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
  };

  # Home manager users
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      jrhin = import ./home.nix;
    };
  };



  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set locale Settings  
  time.timeZone = timeZone;
  i18n = {
    defaultLocale = defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  #programs.hyprland.enable = true;
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = with pkgs; [
  #  xdg-desktop-portal-gtk
  #];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "it2";

  # Configuring Optimus Prime for Nvidia
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:02:0:0";
  };

  # Shell
  programs.zsh.enable = true;
  environment.binsh = "${pkgs.dash}/bin/dash";

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  #--------------------------------------------------------
  #
  #                    SYSTEM PACKAGES
  #
  #--------------------------------------------------------

  environment.systemPackages = with pkgs;
  [
    #dunst
    home-manager
    lazygit
    lf
    #libnotify
    mpv
    nil
    python311 (python311.withPackages(ps: with ps; [
      python-lsp-server
    ]))
    sxiv
    #swww
    #waybar
    #wofi
    zathura
  ];
}
