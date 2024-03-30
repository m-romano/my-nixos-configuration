# NixOS Configuration Guide

This guide outlines the steps and configurations needed to set up a NixOS system. It covers hardware, filesystem, virtual memory, kernel, software configurations, networking, user management, system services, and miscellaneous settings.

# Table of Contents

- [NixOS Configuration Guide](#nixos-configuration-guide)
  - [System Configuration](#system-configuration)
    - [Hardware Configuration](#hardware-configuration)
    - [File System](#file-system)
    - [Virtual Memory](#virtual-memory)
    - [Kernel and Boot Parameters](#kernel-and-boot-parameters)
    - [Kernels schedulers](#kernels-schedulers)
  - [Software Configuration](#software-configuration)
    - [Package Management](#package-management)
    - [ZRAM Swap](#zram-swap)
    - [Graphics Drivers](#graphics-drivers)
    - [Desktop Environment](#desktop-environmet)
    - [Audio](#audio)
    - [Development Tool](#development-tool)
    - [Text editor](#text-editor)
  - [Networking](#networking)
  - [Users and Permissions](#users-and-permissions)
  - [System Services](#system-services)
  - [Miscellaneous](#miscellaneous)

## System Configuration

### Hardware Configuration

- **Hardware Scan**: The system automatically includes the results of the hardware scan through `./hardware-configuration.nix`.

The configuration file `hardware-configuration.nix` is included from `configuration.nix` and will be overwritten by future invocations of nixos-generate-config; thus, you generally should not modify it.


### File System

- **Root Filesystem**: Configured to use the ext4 filesystem on the device identified by partition label `nixos`. The options `noatime` and `commit=60`.

For more detailed information about the options, refer to the [Arch Linux Ext4 Wiki Page](https://wiki.archlinux.org/title/Ext4#Improving_performance).


### Virtual Memory

- **Kernel Sysctl**: Adjustments are made to the virtual memory system, including setting `vm.dirty_ratio` to 10, `vm.dirty_background_ratio` to 5, and `vm.vfs_cache_pressure` to 50.

For more detailed information about the options, refer to the [Arch Linux Sysctl Wiki Page](https://wiki.archlinux.org/title/Sysctl#Virtual_memory).


### Kernel and Boot Parameters

- **Kernel Params**: Specific modules are blacklisted, and the watchdog timer is disabled.

For more detailed information about watchdog, refer to the [Arch Linux Improve Performance Wiki Page](https://wiki.archlinux.org/title/improving_performance#Watchdogs).

### Kernels schedulers
Detailed information about Kernel's schedulers, refer to the [Arch Linux Improve Performance Wiki Page](https://wiki.archlinux.org/title/improving_performance#Kernel's_I/O_schedulers) and change according your disk.

### Software Configuration


#### Package Management

- **Allow Unfree**: Unfree packages are permitted system-wide.

For more detailed information about allowUnfree module, refer to the [NixOS Manual](https://nixos.org/manual/nixpkgs/stable/#chap-packageconfig).


#### ZRAM Swap

- **Enable Swap**: ZRAM-based swap is enabled.

For more detailed information about zramSwap module, refer to the [Search Options NixOS Page (Channel 23.11)](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=zramSwap).


#### Graphics Drivers

- **Intel Drivers**: If you're using an Intel CPU, essential drivers are installed.

For more detailed information about drivers, refer to the [NixOS Manual Page](https://nixos.org/manual/nixos/stable/#sec-x11).


#### Desktop Environmet

- **Plasma5 and X11**: The Plasma5 desktop environment alongside the X11 windowing system is enabled.

For more detailed information about graphical profile, refer to the [NixOS Manual Page](https://nixos.org/manual/nixos/stable/#sec-profile-graphical).


#### Audio

- **Pipewire**: The Pipewire multimedia framework is enabled.

For more detailed information about Pipewire module, refer to the [Search Options NixOS Page (Channel 23.11)](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=services.pipewire).


#### Development Tool

- **Git**: Version control.

For more detailed information about Git module, refer to the [Search Options NixOS Page (Channel 23.11)](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=programs.git).

If you use home manager, also refer to the [Home Manager Options Page](https://home-manager-options.extranix.com/?query=programs.git) for more (useful) options. 


#### Text editor

- **Neovim**: Neovim is installed and set as the default editor.

For more detailed information about neovim module, refer to the [Search Options NixOS Page (Channel 23.11)](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=neovim).


### Networking

- **Systemd-boot and NetworkManager**: The systemd-boot EFI boot loader is used, and NetworkManager is enabled for easy network configuration.


### Users and Permissions

- **User Creation**: A user named `drinkwater` is created with sudo privileges.


### System Services

- **SSH and Firewall**: Secure remote access is configured through OpenSSH, and a basic firewall setup is enabled for security.


### Miscellaneous

- **Fonts, Time Zone, and Locale**: A selection of fonts is installed, and system localization settings are configured for English (US) with a time zone set to Europe/Amsterdam.


