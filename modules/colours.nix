{
  colour,
  variant ? "dark",
  subVariant ? "standard",
}: let
  colours = {
    # Dim Palette
    # https://accessiblepalette.com/?lightness=95,74,67,60,53,46,39,32,25,5&af6a75=1,0&d6855c=1,0&e6bf99=1,0&825e17=1,0&8aa88f=1,0&50958f=1,0&506d95=1,0&412a6f=1,0&766f74=1,15

    # Light Palette
    # https://accessiblepalette.com/?lightness=95,74,67,60,53,46,39,32,25,5&fa9e9e=1,0&ff9d57=1,0&ffbb33=1,0&789550=1,0&4c8ce6=1,0&af8fef=1,0&d6f5f2=1,0&fbf7e9=1,0&a38fa0=1,0

    # standard Palette
    # https://accessiblepalette.com/?lightness=95,74,67,60,53,46,39,32,25,5&a3293d=1,0&df6020=1,0&EBCCAD=1,0&E69900=1,0&36633D=1,0&6BC7BF=1,0&1d64C9=1,0&561DC9=1,0&50494E=1,0

    dark = {
      dim = {
        black = "#150E1C";
        blue = "#ABB7CC";
        cyan = "#96BEB9";
        green = "#A5BCA8";
        grey = "#B9B5B7";
        orange = "#E6A88A";
        purple = "#BDB1CD";
        red = "#D5ACB1";
        white = "#FAEFE5";
        yellow = "#CAB392";
      };

      bright = {
        black = "#131016";
        blue = "#9CB6F0";
        cyan = "#A4BBB8";
        green = "#ABBC90";
        grey = "#C0B2BE";
        orange = "#FF9F5A";
        purple = "#C4A9F3";
        red = "#F99D9D";
        white = "#F5F1E3";
        yellow = "#E9AB31";
      };

      standard = {
        black = "#170C21";
        blue = "#A9B4E7";
        cyan = "#6AC5BD";
        green = "#A7BBA9";
        grey = "#B8B5B7";
        orange = "#F7A179";
        purple = "#C7A9EC";
        red = "#E0A8A9";
        white = "#FAEFE5";
        yellow = "#EEA83E";
      };
    };

    light = {
      dim = {
        black = "#150E1C";
        blue = "#526F96";
        cyan = "#417671";
        green = "#5E7262";
        grey = "#736B6F";
        orange = "#975F43";
        purple = "#786398";
        red = "#975C66";
        white = "#FAEFE5";
        yellow = "#8B6726";
      };

      bright = {
        black = "#131016";
        blue = "#406DB1";
        cyan = "#63706E";
        green = "#5E7440";
        grey = "#776975";
        orange = "#986038";
        purple = "#7762A1";
        red = "#935F5F";
        white = "#F5F1E3";
        yellow = "#8B6724";
      };

      standard = {
        black = "#170C21";
        blue = "#326ACB";
        cyan = "#437671";
        green = "#4F7654";
        grey = "#716B70";
        orange = "#B34F1D";
        purple = "#8250D5";
        red = "#B34B55";
        white = "#FAEFE5";
        yellow = "#946312";
      };
    };
  };
in
  with builtins;
    getAttr colour (getAttr subVariant (getAttr variant colours))
