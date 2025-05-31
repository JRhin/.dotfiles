{ inputs, config, pkgs, lib, ... }:

let
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  stateVersion = "23.11"; # Did you read the comment?

  bootMode = "uefi";
  defaultLocale = "en_US.UTF-8";
  locale = "it_IT.UTF-8";
  shell = "zsh";
  timeZone = "Europe/Rome";
  user = "jrhin";
in {
  
  imports = [
      # Include the results of the hardware scan.
      ../../hardware/thinkpad/hardware-configuration.nix

      ../../modules/home/stylix

      ../../modules/system/clamav
      ../../modules/system/nvidia
      ../../modules/system/pipewire
      ../../modules/system/printing
      inputs.home-manager.nixosModules.default
  ];
  
  # StateVersion
  system.stateVersion = stateVersion;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Boot Settings
  boot = {
    # Boot Loader
    loader = {
      # Grub
      grub.enable = if (bootMode == "grub") then true else false;

      # Uefi
      efi.canTouchEfiVariables = if (bootMode == "uefi") then true else false;
      systemd-boot = {
        enable = if (bootMode == "uefi") then true else false;
        configurationLimit = 5;
      };
    };
  };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Stop ssh because of xz trojan https://github.com/NixOS/nixpkgs/issue/300055
  services.openssh.enable = lib.mkForce false;


  #------------------------------------------------------------
  #
  #                       USERS SETTINGS
  #
  #------------------------------------------------------------
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    ${user} = {
      isNormalUser = true;
      description = user;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.${shell};
    };
  };

  # Home manager users
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      ${user} = import ./home.nix;
    };
  };



  networking.hostName = "thinkpad";
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
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # services.xserver.displayManager.gdm.wayland = true;
  # programs.hyprland.enable = true;
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

  # Shell
  programs.zsh.enable = true;
  environment.binsh = "${pkgs.dash}/bin/dash";

  #--------------------------------------------------------
  #
  #                    SYSTEM PACKAGES
  #
  #--------------------------------------------------------

  environment = {

    sessionVariables = {
      FLAKE = "/home/${user}/.dotfiles";
    };

    systemPackages = with pkgs;
    [
      #dunst
      home-manager
      lazygit
      lf
      #libnotify
      mpv
      nh
      nil
      nix-output-monitor
      nvd
      nvitop
      python311 (python311.withPackages(ps: with ps; [
        python-lsp-server
      ]))
      sxiv
      tailscale
      #swww
      #waybar
      #wofi
      zathura
    ];
  };

  # Tailscale service
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
}
