
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/51c37128-dfb3-4439-ad9d-31f1bebfa62f";
      fsType = "ext4";
      options = [
         "noatime"
	 "commit=60"
      ];
    };
  
  boot.kernel.sysctl = {
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
    "vm.vfs_cache_pressure" = 50;
    "kernel.core_pattern" = "/dev/null";
    "mitigations" = "off";
  };

  boot.kernelParams = [
    "modprobe.blacklist=iTCO_wdt"
    "nowatchdog"
  ];

  nixpkgs.config.allowUnfree = true;

  zramSwap.enable = true;

  hardware.opengl.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
  ];
  
  hardware.opengl.driSupport.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    xkb.layout = "us";
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    pkgs.aha
    plasma-browser-integration
    oxygen
    elisa
    (lib.getBin qttools)
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    audio.enable = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    socketActivation = true;
  };

  qt.enable = true;
  
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
  ];
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git.enable = true;

  services.irqbalance.enable = true;
  
  services.udev = {
    enable = true;
    extraRules = 
      ''
      # NVMe SSD
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
      '';
  };
  
  programs.xwayland.enable = true;
  
  nix.settings = { 
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  
  time.timeZone = "Europe/Amesterdam";

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      # keyMap = "us"; 
      useXkbConfig = true;
  };

   services.printing.enable = true;

  services.xserver.libinput = {
    enable = true;
    touchpad.tapping = false;
  };

  users.users.zhenta = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  };

  environment.systemPackages = with pkgs; [
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

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # services.openssh.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 55252 ];
    # allowedUDPPorts = [ ...  ];
  };

  system.stateVersion = "23.11";

}

