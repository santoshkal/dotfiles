{ config, pkgs, ... }:

{
  home.username = "santosh";
  home.homeDirectory = "/home/santosh";
  home.stateVersion = "26.05";
  
  imports = [
    ./modules/packages.nix
    ./modules/zsh.nix
    ./modules/flameshot.nix
  ];

  # Git configuration
  programs.git = {
    enable = true;
    settings = {
    	user = {
    	  name = "Santosh Kaluskar";  
    	  email = "dtshbl@gmail.com";
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

}
