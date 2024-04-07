{ config, pkgs, ... }:

{
  home.username = "zhenta";
  home.homeDirectory = "/home/zhenta";
  
  # Execute script.
  # home.file.".config/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };
  
  # Template sample.
  # Encode the file content in nix configuration file directly.
  # home.file.".xxx".text = ''
  #     xxx
  # '';
  
  # User packages.
  home.packages = with pkgs; [
    # Programs.
    brave
    vscode
    keepassxc
    jetbrains.idea-ultimate
    transmission_4
  ];

  # Basic configuration of git.
  programs.git = {
    enable = true;
    userName = "drinkwater";
    userEmail = "drink@water.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # foot - A fast, lightweight and minimalistic Wayland terminal emulator
  programs.foot = {
    enable = true;
    # custom settings
    settings = {
      main = {
        term = "xterm-256color";

	      font = "JetBrainsMono Nerd Font Mono:size=11";

	      initial-window-size-pixels="1024x768";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        alpha="0.8";
        background="242424";
	      foreground="ffffff";
      };
    };
  };
  
  # Neovim - Vim-fork focused on extensibility and usability.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  
  # Mpv - a free, open source, and cross-platform media player.
  programs.mpv = {
    enable = true;
    # custom settings
    config = {
      profile="high-quality";
      vo="gpu-next";
      scale-antiring=0.6;
      deband="no";

      dither-depth = 8;

      keep-open="yes";

      screenshot-format="png";
      screenshot-dir="~/Pictures/mpv";
      screenshot-template="%F-%p-%n";
      screenshot-high-bit-depth="no";

      slang="eng,en";
      alang="eng,en,jpn,ja";
    };
    defaultProfiles = ["high-quality"];
  };
  
  # Bash - unix shell.
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    '';

    # shellAliases = {
    #   k = "kubectl";
    #   urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    #   urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    # };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
