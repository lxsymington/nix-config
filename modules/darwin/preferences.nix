{ ... }: {
  system = {
    defaults = {
      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.000;
        # Whether to automatically switch between light and dark mode. The default is false.
        AppleInterfaceStyleSwitchesAutomatically = true;
        # allow key repeat
        ApplePressAndHoldEnabled = false;
        # Jump to the spot that’s clicked on the scroll bar. The default is false.
        AppleScrollerPagingBehavior = true;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        # delay before repeating keystrokes
        InitialKeyRepeat = 10;
        # delay between repeated keystrokes upon holding a key
        KeyRepeat = 1;
      };
      
      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
      };

      # firewall settings
      alf = {
        # 0 = disabled 1 = enabled 2 = blocks all connections except for essential services
        globalstate = 1;
        loggingenabled = 0;
        stealthenabled = 1;
      };

      # dock settings
      dock = {
        autohide = true; # auto show and hide dock
        autohide-delay = 0.0; # remove delay for showing dock
        autohide-time-modifier = 1.0; # how fast is the dock showing animation
        magnification = true; # enable magnification
        minimize-to-application = true; # minimize to application instead of minimizing to dock
        mru-spaces = false;
        orientation = "bottom";
        show-process-indicators = true;
        show-recents = false;
        showhidden = false;
        static-only = false;
        tilesize = 60;
      };

      # file viewer settings
      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = true;
        _FXShowPosixPathInTitle = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      # login window settings
      loginwindow = {
        # disable guest account
        GuestEnabled = false;
        # show name instead of username
        SHOWFULLNAME = false;
      };

      menuExtraClock = {
        Show24Hour = false;
        ShowAMPM = true;
        ShowDate = 0;
        ShowDayOfWeek = true;
        ShowSeconds = true;
      };
      
      screencapture = {
        location = "~/Pictures/Screenshots";
      };
      
      spaces = {
        spans-displays = true;
      };

      # trackpad settings
      trackpad = {
        # silent clicking = 0, default = 1
        ActuationStrength = 1;
        # enable tap to click
        Clicking = true;
        # firmness level, 0 = lightest, 2 = heaviest
        FirstClickThreshold = 1;
        # firmness level for force touch
        SecondClickThreshold = 1;
        # don't allow positional right click
        TrackpadRightClick = true;
        # three finger drag for space switching
        TrackpadThreeFingerDrag = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
