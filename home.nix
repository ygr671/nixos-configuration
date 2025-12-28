{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/modules/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";   
  };
in

{

  home.username = "yzd";
  home.homeDirectory = "/home/yzd";
  home.stateVersion = "25.11";

  # User packages
  home.packages = with pkgs; [
    bat
    tree
    vesktop
    fastfetch
    flameshot # Screenshot tool
    vscodium
    jetbrains.idea-community
    godotPackages_4_5.godot
    sqlitebrowser
    graphviz-nox
    prismlauncher
    # Nix LSP and formatter
    nil
    nixpkgs-fmt
    # Node
    nodejs
    # Look and feel
    xdotool
    # GPG
    gnupg
    # Wallets
    feather
    # Messaging clients
    session-desktop
    simplex-chat-desktop
    # Password manager
    keepassxc
    # Libreoffice
    libreoffice
    # LSPs
    phpactor
    # Browser
    librewolf
    # Notifications
    dunst
    libnotify
  ];

  programs.bash = {
    enable = true;

    shellAliases = {
      check-net = "ping 1.1.1.1";
      nrs = "sudo nixos-rebuild switch --flake";
      cleanup-generations = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3";
    };

    initExtra = ''
      PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'
      PS1="\[\e[92m\]\u\[\e[0m\] in \[\e[38;5;27m\]\w\[\e[0m\]\$( [ -n \"\$PS1_CMD1\" ] && echo \" (\$PS1_CMD1)\" ) \\$ "
    '';
  };

  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.normal = {
        family = "JetBrains Mono Nerd Font";
        style = "Regular";
      };
      font.size = 9;
    };
  };

  # Bat
  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
      style = "numbers,changes,grid";
      paging = "auto";
    };
  };

  # Configurations
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
  
  # Emacs
  programs.emacs = {
    enable = true;
    extraPackages =
      epkgs: with epkgs; [
        eglot
        nix-mode
        use-package
        company
        command-log-mode
        ivy
        swiper
        vterm
        org
        magit
        elcord
      ];
  };

  home.file.".emacs.d".source = ./modules/config/emacs;
  
  /*
    services.redshift = {
      enable = true;

      # Display temperature settings
      temperature = {
        day = 5700;
        night = 3500;
      };

      # Schedule settings
      dawnTime = "6:00-7:45";
      duskTime = "18:00-05:00";

      # General settings
      brightness = {
        day = "1";
        night = "1";
      };

      extraOptions = [
        "-v"
        "-m randr"
      ];

      tray = true;
    };

    services.geoclue2.enable = true;
    location.provider = "geoclue2";
  */

  # Rofi
  programs.rofi = {
    enable = true;
    theme = "Arc-Dark";
  };

  # Dunst
  services.dunst = {
    enable = true;
  };

}
