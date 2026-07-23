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

  # GTK themes and cursors
  gtk = {
    enable = true;

  theme = {
    name = "Juno-ocean";
  };

  iconTheme = {
    name = "Cold Metal";
  };

  cursorTheme = {
    name = "Bibata-Modern-Ice";
    size = 16;
  };
};

  xdg.configFile."xsettingsd/xsettingsd.conf".text = ''
    Net/ThemeName "Juno"
    Net/IconThemeName "Cold Metal"
    Gtk/CursorThemeName "Bibata-Modern-Ice"
    Gtk/CursorThemeSize 16
  '';
  

  # ZSH configuration through home-manager
  programs.zsh = {
    enable = true;
    
    # Use oh-my-zsh for easy plugin management
  oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [
      "git"
      "docker"
      "kubectl"
      "fzf"
      "history"
      "extract"
      "sudo"
      "command-not-found"
    ];
  };    
    # Additional plugins not in oh-my-zsh
plugins = [
  {
    name = "zsh-autosuggestions";
    src = pkgs.zsh-autosuggestions;
  }
  {
    name = "zsh-history-substring-search";
    src = pkgs.zsh-history-substring-search;
  }
  {
    name = "fzf-tab";
    src = pkgs.zsh-fzf-tab;
  }
  {
    name = "powerlevel10k";
    src = pkgs.zsh-powerlevel10k;
  }
  {
    name = "zsh-syntax-highlighting";
    src = pkgs.zsh-syntax-highlighting;
  }
];
    
    
    # Environment variables
	envExtra = ''
	  export EDITOR=nvim
	  export VISUAL=nvim
	  export GIT_EDITOR=nvim

	  export XDG_CONFIG_HOME="$HOME/.config"
	  export XDG_CACHE_HOME="$HOME/.cache"
	  export XDG_DATA_HOME="$HOME/.local/share"
	  export XDG_STATE_HOME="$HOME/.local/state"

	  export PYENV_ROOT="$HOME/.pyenv"

	  export BAT_THEME="Visual Studio Dark+"

	  export LC_ALL="en_US.utf8"
	  export GPG_TTY=$(tty)

	  export NVM_DIR="$HOME/.nvm"

	  if [ -s "$NVM_DIR/nvm.sh" ]; then
	    source "$NVM_DIR/nvm.sh"
	  fi

	  if [ -s "$NVM_DIR/bash_completion" ]; then
	    source "$NVM_DIR/bash_completion"
	  fi
	'';
    
    # History configuration
    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      share = true;
      ignoreDups = true;
    };
    
    # Additional ZSH configuration that goes into .zshrc
	initContent = ''
	if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
	  source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
	fi


	  # History navigation
	  bindkey '^p' history-search-backward
	  bindkey '^n' history-search-forward

	  bindkey '^[[A' history-substring-search-up
	  bindkey '^[[B' history-substring-search-down


	  # FZF
	  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
	  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

	  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


	  # Kubernetes completion
	  source <(kubectl completion zsh)


	  # Google Cloud SDK
	  if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
		source "$HOME/google-cloud-sdk/path.zsh.inc"
	  fi

	  if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
		source "$HOME/google-cloud-sdk/completion.zsh.inc"
	  fi


	  # fzf-git
	  if [ -f "$HOME/fzf-git.sh/fzf-git.sh" ]; then
		source "$HOME/fzf-git.sh/fzf-git.sh"
	  fi


	  # pyenv
	  if command -v pyenv >/dev/null; then
		eval "$(pyenv init - zsh)"
	  fi


	  # fzf shell integration
	  eval "$(fzf --zsh)"


	  # mise
	  if command -v mise >/dev/null; then
		eval "$(mise activate zsh)"
	  fi


	  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


	  [ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
	  [ -f ~/.zsh_local ] && source ~/.zsh_local
	'';
 
 };


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

  home.file.".local/share/themes" = {
    source = ../.themes;
    recursive = true;
  };

  home.file.".local/share/icons" = {
    source = ../.icons;
    recursive = true;
  };

  home.packages = with pkgs; [
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
    hypridle
    rofi
    xsettingsd
    waybar
    thunderbird
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
