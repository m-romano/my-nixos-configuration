# NixOS Configuration Guide

This guide outlines the steps and configurations needed to set up a NixOS system. It covers hardware, filesystem, virtual memory, kernel, software configurations, networking, user management, system services, and miscellaneous settings.

## Table of Contents

- [System Configuration](#system-configuration)
  - [Hardware Configuration](#hardware-configuration)
  - [File System](#file-system)
  - [Virtual Memory](#virtual-memory)
  - [Kernel and Boot Parameters](#kernel-and-boot-parameters)
- [Software Configuration](#software-configuration)
  - [Package Management](#package-management)
  - [ZRAM Swap](#zram-swap)
  - [Graphics Drivers](#graphics-drivers)
  - [Desktop Environment](#desktop-environment)
  - [Audio](#audio)
  - [Development Tool](#development-tool)
  - [Text Editor](#text-editor)
- [Networking](#networking)
- [Users and Permissions](#users-and-permissions)
- [System Services](#system-services)
- [Miscellaneous](#miscellaneous)

## System Configuration

### Hardware Configuration

- **Hardware Scan**: Automatically includes hardware scan results via `./hardware-configuration.nix`. The `hardware-configuration.nix` file, sourced from `configuration.nix`, will be replaced in future `nixos-generate-config` runs. Modifying it directly is not recommended.

### File System

- **Root Filesystem**: Utilizes ext4 on the device with UUID `82bac688-dcf6-491d-8c6d-5ccfefd5796e`, with `noatime` and `commit=60` options for performance. [More on Ext4 Performance](https://wiki.archlinux.org/title/Ext4#Improving_performance).

### Virtual Memory

- **Kernel Sysctl**: Adjusts `vm.dirty_ratio` to 10, `vm.dirty_background_ratio` to 5, and `vm.vfs_cache_pressure` to 50. [More on Virtual Memory](https://wiki.archlinux.org/title/Sysctl#Virtual_memory).

### Kernel and Boot Parameters

- **Kernel Params**: Includes module blacklisting and watchdog timer disablement. [More on Performance Tuning](https://wiki.archlinux.org/title/improving_performance#Watchdogs).

## Software Configuration

#### Package Management

- **Allow Unfree**: Permits system-wide installation of unfree packages. [More on Allow Unfree](https://nixos.org/manual/nixpkgs/stable/#chap-packageconfig).

#### ZRAM Swap

- **Enable Swap**: Enables ZRAM-based swap. [More on ZRAM Swap](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=zramSwap).

#### Graphics Drivers

- **Intel Drivers**: Installs essential drivers for Intel CPUs. [More on Graphics Drivers](https://nixos.org/manual/nixos/stable/#sec-x11).

#### Desktop Environment

- **Plasma5 and X11**: Enables the Plasma5 desktop environment with the X11 windowing system. [More on Graphical Profiles](https://nixos.org/manual/nixos/stable/#sec-profile-graphical).

#### Audio

- **Pipewire**: Activates the Pipewire multimedia framework. [More on Pipewire](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=services.pipewire).

#### Development Tool

- **Git**: Installs Git for version control. [More on Git](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=programs.git). For home manager users, [Home Manager Options](https://home-manager-options.extranix.com/?query=programs.git) provide additional configurations.

#### Text Editor

- **Neovim**: Sets Neovim as the default editor. [More on Neovim](https://search.nixos.org/options?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=neovim).

## Networking

- **Systemd-boot and NetworkManager**: Uses systemd-boot for EFI booting and NetworkManager for network configuration ease.

## Users and Permissions

- **User Creation**: Creates a user named `drinkwater` with sudo privileges.

## System Services

- **SSH and Firewall**: Enables Secure Shell (SSH) for secure remote access and configures a basic firewall for security.

## Miscellaneous

- **Fonts, Time Zone, and Locale**: Installs a selection of fonts and sets system localization to English (US)

