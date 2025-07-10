{config, ...}: {
  system = {
    defaults = {
      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 1;
        "com.apple.sound.beep.volume" = 1.000;
        "com.apple.mouse.tapBehavior" = 1;
        AppleInterfaceStyleSwitchesAutomatically = true; # Whether to automatically switch between light and dark mode. The default is false.
        ApplePressAndHoldEnabled = false; # allow key repeat
        AppleKeyboardUIMode = 3; # full keyboard 3
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleScrollerPagingBehavior = true; # Jump to the spot that’s clicked on the scroll bar. The default is false.
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        InitialKeyRepeat = 10; # delay before repeating keystrokes
        KeyRepeat = 1; # delay between repeated keystrokes upon holding a key
        NSWindowShouldDragOnGesture = true; # Whether to allow dragging windows with three fingers. The default is false.
      };

      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
      };

      # dock settings
      dock = {
        appswitcher-all-displays = true; # show app switcher on all displays
        autohide = true; # auto show and hide dock
        autohide-delay = 0.0; # delay before dock hides
        autohide-time-modifier = 0.0; # delay before dock shows
        expose-animation-duration = 0.12; # duration of animation when activating expose
        expose-group-apps = true; # group windows by app
        launchanim = true; # disable launch animation
        largesize = 96; # size of icons when dock is magnified
        magnification = true; # enable magnification
        minimize-to-application = true; # minimize to application instead of minimizing to dock
        mru-spaces = false; # don't automatically rearrange spaces based on most recently used
        orientation = "bottom"; # position of dock
        show-process-indicators = true; # show indicator lights for open applications
        show-recents = false; # don't show recent applications
        showhidden = false; # don't show hidden applications
        static-only = false; # show all applications, not just running applications
        tilesize = 48; # size of icons when dock is not magnified
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
        GuestEnabled = false; # disable guest account
        SHOWFULLNAME = false; # show name instead of username
      };

      menuExtraClock = {
        Show24Hour = false;
        ShowAMPM = true;
        ShowDate = 0;
        ShowDayOfWeek = true;
        ShowSeconds = true;
      };

      screencapture = {
        location = "${config.user.home}/Pictures/Screenshots";
      };

      spaces = {
        spans-displays = false;
      };

      # trackpad settings
      trackpad = {
        ActuationStrength = 1; # silent clicking = 0, default = 1
        Clicking = true; # enable tap to click
        FirstClickThreshold = 1; # firmness level, 0 = lightest, 2 = heaviest
        SecondClickThreshold = 1; # firmness level for force touch
        TrackpadRightClick = true; # don't allow positional right click
        TrackpadThreeFingerDrag = true; # three finger drag for space switching
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  networking = {
    applicationFirewall = {
      enable = true;
      enableStealthMode = true;
    };
  };
}
