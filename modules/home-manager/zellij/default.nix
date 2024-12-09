{ ... }:

let
  theme = import ../../colours.nix;
in
{
  programs = {
    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      settings = {
        default_layout = "default";
        default_mode = "locked";
        pane_frames = false;
        simplified_ui = true;
        styled_underlines = true;
        themes = {
          default = {
            fg = theme { colour = "white"; subVariant = "dim"; };
            bg = theme { colour = "grey"; subVariant = "dim"; };
            black = theme { colour = "black"; };
            red = theme { colour = "red"; subVariant = "dim"; };
            green = theme { colour = "green"; subVariant = "dim"; };
            yellow = theme { colour = "yellow"; subVariant = "dim"; };
            blue = theme { colour = "blue"; subVariant = "dim"; };
            magenta = theme { colour = "purple"; subVariant = "dim"; };
            cyan = theme { colour = "cyan"; subVariant = "dim"; };
            white = theme { colour = "white"; subVariant = "bright"; };
            orange = theme { colour = "orange"; subVariant = "dim"; };
          };
        };
      };
    };
  };
}

/* keybinds = {
  _args = [ "clear-defaults=true" ];
  normal = { };
  locked = {
  "bind \"Ctrl g\"" = { SwitchToMode = "Normal"; };
  };
  resize = {
  "bind \"Ctrl r\"" = { SwitchToMode = "Normal"; };
  "bind \"h\" \"Left\"" = { Resize = "Increase Left"; };
  "bind \"j\" \"Down\"" = { Resize = "Increase Down"; };
  "bind \"k\" \"Up\"" = { Resize = "Increase Up"; };
  "bind \"l\" \"Right\"" = { Resize = "Increase Right"; };
  "bind \"H\"" = { Resize = "Decrease Left"; };
  "bind \"J\"" = { Resize = "Decrease Down"; };
  "bind \"K\"" = { Resize = "Decrease Up"; };
  "bind \"L\"" = { Resize = "Decrease Right"; };
  "bind \"=\" \"+\"" = { Resize = "Increase"; };
  "bind \"-\"" = { Resize = "Decrease"; };
  };
  pane = {
  "bind \"Ctrl p\"" = { SwitchToMode = "Normal"; };
  "bind \"h\" \"Left\"" = { MoveFocus = "Left"; };
  "bind \"l\" \"Right\"" = { MoveFocus = "Right"; };
  "bind \"j\" \"Down\"" = { MoveFocus = "Down"; };
  "bind \"k\" \"Up\"" = { MoveFocus = "Up"; };
  "bind \"p\"" = { SwitchFocus = true; };
  "bind \"n\"" = { NewPane = true; SwitchToMode = "Normal"; };
  "bind \"d\"" = { NewPane = "Down"; SwitchToMode = "Normal"; };
  "bind \"r\"" = { NewPane = "Right"; SwitchToMode = "Normal"; };
  "bind \"x\"" = { CloseFocus = true; SwitchToMode = "Normal"; };
  "bind \"f\"" = { ToggleFocusFullscreen = true; SwitchToMode = "Normal"; };
  "bind \"z\"" = { TogglePaneFrames = true; SwitchToMode = "Normal"; };
  "bind \"w\"" = { ToggleFloatingPanes = true; SwitchToMode = "Normal"; };
  "bind \"e\"" = { TogglePaneEmbedOrFloating = true; SwitchToMode = "Normal"; };
  "bind \"c\"" = { SwitchToMode = "RenamePane"; PaneNameInput = 0; };
  };
  move = {
  "bind \"Ctrl m\"" = { SwitchToMode = "Normal"; };
  "bind \"n\" \"Tab\"" = { MovePane = true; };
  "bind \"p\"" = { MovePaneBackwards = true; };
  "bind \"h\" \"Left\"" = { MovePane = "Left"; };
  "bind \"j\" \"Down\"" = { MovePane = "Down"; };
  "bind \"k\" \"Up\"" = { MovePane = "Up"; };
  "bind \"l\" \"Right\"" = { MovePane = "Right"; };
  };
  tab = {
  "bind \"Ctrl t\"" = { SwitchToMode = "Normal"; };
  "bind \"r\"" = { SwitchToMode = "RenameTab"; TabNameInput = 0; };
  "bind \"h\" \"Left\" \"Up\" \"k\"" = { GoToPreviousTab = true; };
  "bind \"l\" \"Right\" \"Down\" \"j\"" = { GoToNextTab = true; };
  "bind \"n\"" = { NewTab = true; SwitchToMode = "Normal"; };
  "bind \"x\"" = { CloseTab = true; SwitchToMode = "Normal"; };
  "bind \"s\"" = { ToggleActiveSyncTab = true; SwitchToMode = "Normal"; };
  "bind \"b\"" = { BreakPane = true; SwitchToMode = "Normal"; };
  "bind \"]\"" = { BreakPaneRight = true; SwitchToMode = "Normal"; };
  "bind \"[\"" = { BreakPaneLeft = true; SwitchToMode = "Normal"; };
  "bind \"1\"" = { GoToTab = 1; SwitchToMode = "Normal"; };
  "bind \"2\"" = { GoToTab = 2; SwitchToMode = "Normal"; };
  "bind \"3\"" = { GoToTab = 3; SwitchToMode = "Normal"; };
  "bind \"4\"" = { GoToTab = 4; SwitchToMode = "Normal"; };
  "bind \"5\"" = { GoToTab = 5; SwitchToMode = "Normal"; };
  "bind \"6\"" = { GoToTab = 6; SwitchToMode = "Normal"; };
  "bind \"7\"" = { GoToTab = 7; SwitchToMode = "Normal"; };
  "bind \"8\"" = { GoToTab = 8; SwitchToMode = "Normal"; };
  "bind \"9\"" = { GoToTab = 9; SwitchToMode = "Normal"; };
  "bind \"Tab\"" = { ToggleTab = true; };
  };
  scroll = {
  "bind \"Ctrl s\"" = { SwitchToMode = "Normal"; };
  "bind \"e\"" = { EditScrollback = true; SwitchToMode = "Normal"; };
  "bind \"s\"" = { SwitchToMode = "EnterSearch"; SearchInput = 0; };
  "bind \"Ctrl c\"" = { ScrollToBottom = true; SwitchToMode = "Normal"; };
  "bind \"j\" \"Down\"" = { ScrollDown = true; };
  "bind \"k\" \"Up\"" = { ScrollUp = true; };
  "bind \"Ctrl f\" \"PageDown\" \"Right\" \"l\"" = { PageScrollDown = true; };
  "bind \"Ctrl b\" \"PageUp\" \"Left\" \"h\"" = { PageScrollUp = true; };
  "bind \"d\"" = { HalfPageScrollDown = true; };
  "bind \"u\"" = { HalfPageScrollUp = true; };
  "bind \"Alt left\"" = { MoveFocusOrTab = "left"; SwitchToMode = "normal"; };
  "bind \"Alt down\"" = { MoveFocus = "down"; SwitchToMode = "normal"; };
  "bind \"Alt up\"" = { MoveFocus = "up"; SwitchToMode = "normal"; };
  "bind \"Alt right\"" = { MoveFocusOrTab = "right"; SwitchToMode = "normal"; };
  "bind \"Alt h\"" = { MoveFocusOrTab = "left"; SwitchToMode = "normal"; };
  "bind \"Alt j\"" = { MoveFocus = "down"; SwitchToMode = "normal"; };
  "bind \"Alt k\"" = { MoveFocus = "up"; SwitchToMode = "normal"; };
  "bind \"Alt l\"" = { MoveFocusOrTab = "right"; SwitchToMode = "normal"; };
  };
  search = {
  "bind \"Ctrl s\"" = { SwitchToMode = "Normal"; };
  "bind \"Ctrl c\"" = { ScrollToBottom = true; SwitchToMode = "Normal"; };
  "bind \"j\" \"Down\"" = { ScrollDown = true; };
  "bind \"k\" \"Up\"" = { ScrollUp = true; };
  "bind \"Ctrl f\" \"PageDown\" \"Right\" \"l\"" = { PageScrollDown = true; };
  "bind \"Ctrl b\" \"PageUp\" \"Left\" \"h\"" = { PageScrollUp = true; };
  "bind \"d\"" = { HalfPageScrollDown = true; };
  "bind \"u\"" = { HalfPageScrollUp = true; };
  "bind \"n\"" = { Search = "down"; };
  "bind \"p\"" = { Search = "up"; };
  "bind \"c\"" = { SearchToggleOption = "CaseSensitivity"; };
  "bind \"w\"" = { SearchToggleOption = "Wrap"; };
  "bind \"o\"" = { SearchToggleOption = "WholeWord"; };
  };
  entersearch = {
  "bind \"Ctrl c\" \"Esc\"" = { SwitchToMode = "Scroll"; };
  "bind \"r\"" = { SwitchToMode = "Search"; };
  };
  renametab = {
  "bind \"c\"" = { SwitchToMode = "Normal"; };
  "bind \"Esc\"" = { UndoRenameTab = true; SwitchToMode = "Tab"; };
  };
  renamepane = {
  "bind \"c\"" = { SwitchToMode = "Normal"; };
  "bind \"Esc\"" = { UndoRenamePane = true; SwitchToMode = "Pane"; };
  };
  session = {
  "bind \"Ctrl o\"" = { SwitchToMode = "Normal"; };
  "bind \"Ctrl s\"" = { SwitchToMode = "Scroll"; };
  "bind \"d\"" = { Detach = true; };
  "bind \"w\"" = {
      "LaunchOrFocusPlugin \"session-manager\"" = {
        floating = true;
        move_to_focused_tab = true;
      };
      SwitchToMode = "Normal";
  };
  "bind \"c\"" = {
      "LaunchOrFocusPlugin \"configuration\"" = {
        floating = true;
        move_to_focused_tab = true;
      };
      SwitchToMode = "Normal";
  };
  "bind \"p\"" = {
      "LaunchOrFocusPlugin \"plugin-manager\"" = {
        floating = true;
        move_to_focused_tab = true;
      };
      SwitchToMode = "Normal";
  };
  };
  tmux = {
  "bind \"[\"" = { SwitchToMode = "Scroll"; };
  "bind \"Ctrl b\"" = { Write = 2; SwitchToMode = "Normal"; };
  "bind \"\\\"" = { NewPane = "Down"; SwitchToMode = "Normal"; };
  "bind \"%\"" = { NewPane = "Right"; SwitchToMode = "Normal"; };
  "bind \"z\"" = { ToggleFocusFullscreen = true; SwitchToMode = "Normal"; };
  "bind \"c\"" = { NewTab = true; SwitchToMode = "Normal"; };
  "bind \",\"" = { SwitchToMode = "RenameTab"; };
  "bind \"p\"" = { GoToPreviousTab = true; SwitchToMode = "Normal"; };
  "bind \"n\"" = { GoToNextTab = true; SwitchToMode = "Normal"; };
  "bind \"Left\"" = { MoveFocus = "Left"; SwitchToMode = "Normal"; };
  "bind \"Right\"" = { MoveFocus = "Right"; SwitchToMode = "Normal"; };
  "bind \"Down\"" = { MoveFocus = "Down"; SwitchToMode = "Normal"; };
  "bind \"Up\"" = { MoveFocus = "Up"; SwitchToMode = "Normal"; };
  "bind \"h\"" = { MoveFocus = "Left"; SwitchToMode = "Normal"; };
  "bind \"l\"" = { MoveFocus = "Right"; SwitchToMode = "Normal"; };
  "bind \"j\"" = { MoveFocus = "Down"; SwitchToMode = "Normal"; };
  "bind \"k\"" = { MoveFocus = "Up"; SwitchToMode = "Normal"; };
  "bind \"o\"" = { FocusNextPane = true; };
  "bind \"d\"" = { Detach = true; };
  "bind \"Space\"" = { NextSwapLayout = true; };
  "bind \"x\"" = { CloseFocus = true; SwitchToMode = "Normal"; };
  };
  "shared_except \"locked\"" = {
  "bind \"Ctrl g\"" = { SwitchToMode = "Locked"; };
  "bind \"Ctrl q\"" = { Quit = true; };
  "bind \"Alt f\"" = { ToggleFloatingPanes = true; };
  "bind \"Alt n\"" = { NewPane = true; };
  "bind \"Alt i\"" = { MoveTab = "Left"; };
  "bind \"Alt o\"" = { MoveTab = "Right"; };
  "bind \"Alt h\" \"Alt Left\"" = { MoveFocusOrTab = "Left"; };
  "bind \"Alt l\" \"Alt Right\"" = { MoveFocusOrTab = "Right"; };
  "bind \"Alt j\" \"Alt Down\"" = { MoveFocus = "Down"; };
  "bind \"Alt k\" \"Alt Up\"" = { MoveFocus = "Up"; };
  "bind \"Alt =\" \"Alt +\"" = { Resize = "Increase"; };
  "bind \"Alt -\"" = { Resize = "Decrease"; };
  "bind \"Alt [\"" = { PreviousSwapLayout = true; };
  "bind \"Alt ]\"" = { NextSwapLayout = true; };
  };
  "shared_except \"normal\" \"locked\"" = {
  "bind \"Enter\" \"Esc\"" = { SwitchToMode = "Normal"; };
  };
  "shared_except \"pane\" \"locked\"" = {
  "bind \"p\"" = { SwitchToMode = "Pane"; };
  };
  "shared_except \"resize\" \"locked\"" = {
  "bind \"r\"" = { SwitchToMode = "Resize"; };
  };
  "shared_except \"scroll\" \"locked\"" = {
  "bind \"s\"" = { SwitchToMode = "Scroll"; };
  };
  "shared_except \"session\" \"locked\" \"tab\"" = {
  "bind \"o\"" = { SwitchToMode = "Session"; };
  };
  "shared_except \"tab\" \"locked\"" = {
  "bind \"t\"" = { SwitchToMode = "Tab"; };
  };
  "shared_except \"move\" \"locked\"" = {
  "bind \"m\"" = { SwitchToMode = "Move"; };
  };
  "shared_except \"tmux\" \"locked\"" = {
  "bind \"b\"" = { SwitchToMode = "Tmux"; };
  };
}; */
