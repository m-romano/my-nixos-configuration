
{ config, lib, pkgs, ... }:

{
  # Hardware
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # System
  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
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
    "vm.swappiness" = 10;
    "kernel.core_pattern"="|/bin/false";
    "mitigations" = "off";
    "net.core.netdev_max_backlog" = 16384;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_max_syn_backlog" = 8192;
    "net.ipv4.tcp_max_tw_buckets" = 2000000;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_fin_timeout" = 10;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_keepalive_time" = 60;
    "net.ipv4.tcp_keepalive_intvl" = 10;
    "net.ipv4.tcp_keepalive_probes" = 6;
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.ipv4.tcp_timestamps" = 0;
    "net.ipv4.tcp_sack" = 1;
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
  };

  boot.kernelParams = [
    "modprobe.blacklist=iTCO_wdt"
    "nowatchdog"
    "tcp_bbr"
  ];

  services.udev = {
    enable = true;
    extraRules = 
      ''
      # NVMe SSD
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"

      # Set device MTU and queue length
      ACTION=="add", SUBSYSTEM=="net", KERNEL=="wl*", ATTR{mtu}="1500", ATTR{tx_queue_len}="2000"
      '';
  };

  hardware.opengl.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
  ];
  
  hardware.opengl.driSupport.enable = true;

  zramSwap.enable = true;

  services.fstrim.enable = true;

  services.irqbalance.enable = true;

  # Nix
  nix.settings = { 
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # Nixpkgs
  nixpkgs.config.allowUnfree = true;

  # Graphical
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

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
  ];

  qt.enable = true;

  programs.xwayland.enable = true;
  
  # Programs
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ ... ];
    # allowedUDPPorts = [ ... ]:
  };

  time.timeZone = "Europe/Amsterdam";

  services.openssh.enable = true;
  
  # Input
  i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      # keyMap = "us"; 
      useXkbConfig = true;
  };
  
  services.xserver.libinput = {
    enable = true;
    touchpad.tapping = false;
  };
  
  # User
  users.users.zhenta = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  
  # System packages
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
  ];

  # State Version
  system.stateVersion = "23.11";

}

