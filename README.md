# NixOS Configuration Guide

## System Configuration

### Hardware Configuration

- **Hardware Scan**: The system automatically includes the results of the hardware scan through `./hardware-configuration.nix`.

### File System

- **Root Filesystem**: Configured to use the ext4 filesystem on the device identified by UUID `f61a5ecb-34ec-41c9-9ac2-13235d9a9a62`. The options `noatime` and `commit=60` are set for optimized disk access.

### Virtual Memory

- **Kernel Sysctl**: Adjustments are made to the virtual memory system, including setting `vm.dirty_ratio` to 10, `vm.dirty_background_ratio` to 5, and `vm.vfs_cache_pressure` to 50.

### Kernel and Boot Parameters

- **Kernel Params**: Specific modules are blacklisted, and the watchdog timer is disabled.

### Software Configuration

#### Package Management

- **Allow Unfree**: Unfree packages are permitted, enabling a broader selection of software.

#### ZRAM Swap

- **Enable Swap**: ZRAM-based swap is enabled.

#### Graphics Drivers

- **Intel Drivers**: If you're using an Intel CPU, essential drivers are installed to ensure optimal graphics performance.

#### Desktop Environment

- **Plasma5 and X11**: The Plasma5 desktop environment alongside the X11 windowing system is enabled.

#### Audio

- **Pipewire**: The Pipewire multimedia framework is enabled.

#### Development Tools

- **Neovim**: Neovim is installed and set as the default editor.

- **Git**: Version control.

### Networking

- **Systemd-boot and NetworkManager**: The systemd-boot EFI boot loader is used, and NetworkManager is enabled for easy network configuration.

### Users and Permissions

- **User Creation**: A user named `drinkwater` is created with sudo privileges, ensuring administrative tasks can be performed easily.

### System Services

- **SSH and Firewall**: Secure remote access is configured through OpenSSH, and a basic firewall setup is enabled for security.

### Miscellaneous

- **Fonts, Time Zone, and Locale**: A selection of fonts is installed, and system localization settings are configured for English (US) with a time zone set to Europe/Rome.

## Customizing Your Configuration

This configuration serves as a foundation. You can edit various sections according to your hardware specifications, preferences, and requirements. For instance:

- Update the UUID in the file system configuration to match your disk.
- Adjust kernel parameters and sysctl settings based on your performance and security needs.
- Choose your preferred desktop environment and applications.
- Tailor the user setup by changing the username and group memberships.

Remember, after making changes to your `configuration.nix`, execute `nixos-rebuild switch` to apply them.

## Additional Resources

For more detailed information on configuring NixOS, refer to the [NixOS Manual](https://nixos.org/manual/nixos/stable/). It provides comprehensive guidance on system configuration, package management, and much more.

