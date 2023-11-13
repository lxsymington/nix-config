{ colour, variant ? "standard" }:
let
  colours = {
    dim = {
      black = "#42334d";
      blue = "#506d95";
      cyan = "#50958f";
      green = "#8aa88f";
      grey = "#766f74";
      orange = "#d6855c";
      purple = "#412a6f";
      red = "#af6a75";
      white = "#e6bf99";
      yellow = "#825e17";
    };

    light = {
      black = "#281d30";
      blue = "#4c8ce6";
      cyan = "#d6f5f2";
      green = "#789550";
      grey = "#a38fa0";
      orange = "#ff9d57";
      purple = "#af8fef";
      red = "#fa9e9e";
      white = "#fbf7e9";
      yellow = "#ffbb33";
    };

    standard = {
      black = "#1b1320";
      blue = "#1d64c9";
      cyan = "#6bc7bf";
      green = "#36633d";
      grey = "#50494e";
      orange = "#df6020";
      purple = "#561dc9";
      red = "#a3293d";
      white = "#ebccad";
      yellow = "#e69900";
    };
  };
in
with builtins;
getAttr colour (getAttr variant colours)
