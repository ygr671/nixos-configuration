{ config, pkgs, ... }:

{
  
  home.username = "yzd";
  home.homeDirectory = "/home/yzd";
  home.stateVersion = "25.05";

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
    # Neovim dependencies
    nil
    nixpkgs-fmt
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
    # Emacs stuff
    emacsPackages.vterm
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
  
  # Bash
  programs.bash = {
    enable = true;
    shellAliases = {
      check-net = "ping 1.1.1.1";
      nrs = "sudo nixos-rebuild switch --flake";
      cleanup-generations = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3";
    };

    initExtra = ''
      export PS1='\[\e[92m\]\u\[\e[0m\] in \[\e[38;5;27m\]\w\[\e[0m\] \\$ '
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
  
  # Qtile
  home.file.".config/qtile" = {
    source = ./modules/dotfiles/qtile;
    recursive = true;
  };

  # Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      
      vim.opt.number = true
      vim.opt.relativenumber = true

      vim.cmd("colorscheme industry")
      
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2 
      vim.opt.smartindent = true
      
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = true
      vim.opt.incsearch = true
      vim.opt.cursorline = true
      vim.opt.wrap = false
      vim.opt.scrolloff = 8
      vim.opt.updatetime = 200
      
      vim.opt.clipboard = "unnamedplus"
    '';
    
    plugins = with pkgs.vimPlugins; [
      vim-be-good
    ];   
  };

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
