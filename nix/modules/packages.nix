
  {pkgs, ...}:

  {
    home.packages = with pkgs; [
      neovim
      google-chrome

      go
      nodejs
      rustc
      cargo
      python3

      bat
      fzf
      lazygit
      tmux
      kubectl
      ghostty
      kitty
      pyenv
      chezmoi
      hyprpaper
      hypridle
      rofi
      xsettingsd
      waybar
      thunderbird
      terraform
      nemo

    # Nix Search TV a shortcut 'ns' for searching nixOS packages
      (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })

    ];
  }
