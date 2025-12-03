# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  
  # home-manager.useUserPackages = true;
  # home-manager.useGlobalPkgs = true;
  # home-manager.backupFileExtension = "backup";
  # home-manager.users.yzd = import ./home.nix;
  

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zenith"; # Define your hostname.

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };
  
  # Wallpaper
  environment.etc."wallpapers/red-moon.png".source = ./data/wallpapers/red-moon.png;

  services.displayManager.ly.enable = true;
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    xkb.layout = "fr";
    xkb.variant = "";
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    displayManager.sessionCommands = ''
      xwallpaper --zoom /etc/wallpapers/red-moon.png 
      # Screen saver
      xset s 300 300
      # Sleeping
      xset dpms 600 600 600

    '';
  };
  
  # Compositor (picom) configuration
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    vSync = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Allowing Unfree apps
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yzd = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim # Text editor
    emacs
    alacritty # Terminal emulator
    btop
    git # Versionning tool
    meld # Diff and merge tool
    xwallpaper # Wallpaper tool
    pcmanfm # File manager
    rofi # App launcher
    pfetch 
    tmux # Terminal multiplexer
    ly # TUI display manager
    lyx # Latex document processor
    xclip # Clipboard
    # C/C++
    gcc
    gdb
    gnumake
    cmake
    clang-tools
    pkg-config
    libtool
    ripgrep
    fzf
    luajit
    valgrind
    # Neovim
    tree-sitter
    tree-sitter-grammars.tree-sitter-c
    tree-sitter-grammars.tree-sitter-cpp
    tree-sitter-grammars.tree-sitter-python
    tree-sitter-grammars.tree-sitter-go
    # Function hotkeys
    brightnessctl
    # PHP
    php84
    php84Packages.composer 
    php84Extensions.curl
    php84Extensions.xml
    # Notifications
    libnotify
    # VPN
    openfortivpn
    # Bluetooth
    bluetui
  ];

  # Fonts
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    jetbrains-mono
  ];

  # Git configuration
  programs.git = {
    enable = true;
    
    config = {
      init.defaultBranch = "main";
      user = {
        name = "Muhammed ERDAL"; 
        email = "m.erdal677@proton.me";
      };
      merge.tool = "meld";
    };
  };
  
  # Start SSH agent
  services.openssh.enable = true;
  services.openssh.startWhenNeeded = true;

  programs.ssh.startAgent = true;

  # VPN configuration
  environment.etc."openfortivpn".source = ./modules/services/openfortivpn;
  
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

