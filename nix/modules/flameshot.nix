  {config,pkgs, ... }:

  {
    # Flameshot
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledGrimWarning = true;
          savePath = "/home/santosh-nix/Pictures";
          saveAsFileExtension = "png";
          showSidePanelButton = true;
          useGrimAdaptor = true;
          disabledTrayIcon = false;
        };
      };
    };
  }
