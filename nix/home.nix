{ config, pkgs, ... }:

{
  home.username = "santosh";
  home.homeDirectory = "/home/santosh";
  home.stateVersion = "26.05";
  
  # Git configuration
  programs.git = {
    enable = true;
    settings = {
    	user = {
    	  name = "Santosh Kaluskar";  # Add your git user name
    	  email = "dtshbl@gmail.com";  # Add your git email
	};
    };
  };

  home.file.".zshrc".source = ../.zshrc;

  xdg.configFile."hypr" = {
  source = ../.config/hypr;
  };
  
  xdg.configFile."rofi" = {
  source = ../.config/rofi;
  };

  xdg.configFile."nvim" = {
  source = ../.config/nvim;
  };

  xdg.configFile."ghostty" = {
  source = ../.config/ghostty;
  };

  xdg.configFile."waybar" = {
  source = ../.config/waybar;
  };

  home.packages = with pkgs; [
    zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    zsh-vi-mode
    command-not-found
    zsh-bat
    bat
    fd
    fzf
    ripgrep
    lazygit
    tmux
    neovim
    kubectl
    ghostty
    kitty
    pyenv
    chezmoi
    hyprpaper
    pypridle
    hyprland
    rofi
    waybar
  ];

}
