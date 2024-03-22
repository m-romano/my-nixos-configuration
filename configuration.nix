# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Override root filesystem config and edit options.
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/82bac688-dcf6-491d-8c6d-5ccfefd5796e"; # Edit the UUID by running `blkid` to find it.
      fsType = "ext4";
      options = [
         "noatime"
	 "commit=60"
      ];
    };
  
  # Edit virtual memory options.
  boot.kernel.sysctl = {
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
    "vm.vfs_cache_pressure" = 50;
    "kernel.core_pattern" = "/dev/null";
    "mitigations" = "off"; # Edit if you have Intel above 8th/9th gen.
  };

  # Edit kernel and boot parameters.
  boot.kernelParams = [
    "modprobe.blacklist=iTCO_wdt"
    "nowatchdog"
  ];

  # Allow installation of packages with unfree licenses system-wide.
  nixpkgs.config.allowUnfree = true;

  # Enable Swap using ZRAM.
  zramSwap.enable = true;

  # Install Intel drivers based on your CPU model.
  hardware.opengl.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
  ];
  
  # Enable DRI support for Mesa and Vulkan.
  hardware.opengl.driSupport.enable = true;

  # Enable and configure the X11 windowing system along with Plasma5, SDDM, and video drivers.
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    xkb.layout = "us";
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
    libinput = {
      enable = true;
      touchpad.tapping = false;
    };
  };

  # Exclude packages from Plasma5.
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [ # Edit according your preferences.
    pkgs.aha
    plasma-browser-integration
    oxygen
    elisa
    (lib.getBin qttools)
  ];

  # Install and enable Pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    audio.enable = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    socketActivation = true;
  };

  # Install and enable QT integration.
  qt.enable = true;
  
  # Install a selection of system-wide fonts.
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
  ];
  
  # Install, enable and set neovim as default editor.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Install and enable git.
  programs.git.enable = true;

  # Install and enable IRQBalance.
  services.irqbalance.enable = true;

  # Install and enable xwayland.
  programs.xwayland.enable = true;
  
  # Unstable! Enable experimental features.
  # https://nixos.org/manual/nix/stable/contributing/experimental-features
  # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix
  # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake
  nix.settings = { experimental-features = "nix-command flakes"; };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Set hostname and enable networkmanager.
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
  };
  
  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      # keyMap = "us"; # Commented because is not unique. 
      useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drinkwater = { # Edit user name.
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user and add user to ‘networkmanager‘ group.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ # Edit according your preferences.
    wget
    brave
    temurin-bin-21
    mpv-unwrapped
    vscode
    keepassxc
    p7zip
    jetbrains.idea-ultimate
    transmission_4
    python3
    scrcpy
    android-tools
    lm_sensors
    calibre
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ ...  ];
    # allowedUDPPorts = [ ...  ];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

