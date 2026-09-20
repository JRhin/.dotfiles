{ inputs, config, pkgs, lib, ... }:

let
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  stateVersion = "26.05"; # Did you read the comment?

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

      ../../modules/system/stylix

      ../../modules/system/automount
      ../../modules/system/clamav
      ../../modules/system/fwupd
      ../../modules/system/greeter
      ../../modules/system/memory
      ../../modules/system/niri
      ../../modules/system/noctalia
      ../../modules/system/nvidia
      ../../modules/system/pipewire
      ../../modules/system/printing
      ../../modules/system/thermald

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
      trusted-users = [ "root" "@wheel" ];
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;   # silences "Git tree is dirty"
    };

    # Make `nix run nixpkgs#x` and `nix-shell -p` use the flake's locked nixpkgs (works offline)
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    channel.enable = false;
  };

  #------------------------------------------------------------
  #
  #                       Nix Helpers
  #
  #------------------------------------------------------------

  programs.nh = {
    enable = true;

    # Also sets NH_FLAKE, replacing the session variable
    flake = "/home/${user}/.dotfiles";

    # Automatic cleanup, aligned with configurationLimit = 5
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };

  # Lets generic prebuilt Linux binaries run (pip wheels, editor servers, native tools)
  programs.nix-ld.enable = true;

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
      extraGroups = [ "networkmanager" "wheel" "input" ];
      shell = pkgs.${shell};
    };
  };

  # Home manager users
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
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
  services = {
    xserver.enable = true;
  };

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

    systemPackages = with pkgs;
    [
      imv
      nix-output-monitor
      nvd
      nvitop
    ];
  };

  # Docker / Podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;   # provides a `docker` command that runs podman
    defaultNetwork.settings.dns_enabled = true;
  };

  # Tailscale service
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
}
