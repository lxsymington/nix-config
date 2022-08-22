{ config, pkgs, ... }:

let
  lxs_dotfiles = builtins.fetchGit {
    url = "git@github.com:lxsymington/dotfiles.git";
    ref = "main";
    rev = "172c7800c3ec3d64a29f9b4bb17408b53ad931e1";
  };
  lxs_tmux_config = builtins.readFile (builtins.toPath "${lxs_dotfiles}/tmux/.tmux.conf");
in
{
  manual.manpages.enable = true;

  home.username = "lukexaviersymington";
  home.homeDirectory = "/Users/lukexaviersymington";
  home.packages = with pkgs; [
    delta
    fd
    figlet
    gojq
    multimarkdown
    pandoc
    pinentry
    pinentry_mac
    xh
  ];
  home.stateVersion = "22.11";
  home.shellAliases = {
    renix = "darwin-rebuild switch --flake ~/.config/nixpkgs#";
    jq = "gojq";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  programs.home-manager.enable = true;
  programs.bat = {
    enable = true;
    config = {
      theme = "Solarized (light)";
      italic-text = "always";
      pager = "less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
      map-syntax = [ ".ignore:Git Ignore" ];
    };
  };
  programs.bottom.enable = true;
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
        fish_vi_key_bindings
    '';
    plugins = [
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "d6abb267bb3fb7e987a9352bc43dcdb67bac9f06";
          sha256 = "1h8v5jg9kkali50qq0jn0i1w68wp4c2l0fapnglnnpg0v4vv51za";
        };
      }
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
          sha256 = "1fvl23y9lylj4nz6k7yfja6v9jlsg8jffs2m5mq0ql4ja5vi5pkv";
        };
      }
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "fzf";
          rev = "479fa67d7439b23095e01b64987ae79a91a4e283";
          sha256 = "0k6l21j192hrhy95092dm8029p52aakvzis7jiw48wnbckyidi6v";
        };
      }
      {
        name = "pisces";
        src = pkgs.fetchFromGitHub {
          owner = "laughedelic";
          repo = "pisces";
          rev = "e45e0869855d089ba1e628b6248434b2dfa709c4";
          sha256 = "073wb83qcn0hfkywjcly64k6pf0d7z5nxxwls5sa80jdwchvd2rs";
        };
      }
      {
        name = "replay";
        src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "replay.fish";
            rev = "bd8e5b89ec78313538e747f0292fcaf631e87bd2";
            sha256 = "0inniabgdbd7yq71rpmpnzhbk8y23ggvlk4jhaapc7bz0yhbxkkc";
        };
      }
    ];
  };
  programs.git = {
    enable = true;
    userName = "Luke Xavier Symington";
    userEmail = "lukexaviersymington@gmail.com";
    aliases = {
      co = "checkout";
      # Show last commit
      lc = "diff-tree --name-status -r -v HEAD";
      # List git aliases
      la = "!git config -l | grep alias | cut -c 7-";
      # Display conflicts
      cx = "diff --name-only --diff-filter=U";
      # Add and commit
      record = "! sh -c '(git add -p -- $argv && git commit) || git reset' --";
      # Log git history in a pretty graph
      lg = "log --color=always --graph --date=short --pretty=format:'%C(green)%C(bold)%cd %C(auto)%h%d %s %m %C(magenta)%C(italic)[%an]%C(reset)' --abbrev-commit";
      branches = "for-each-ref --color=always --sort=-committerdate --format='%(color:red)%(objectname:short)%(color:reset) | %(color:yellow)%(refname:short)%(color:reset) |> %(color:magenta)%(authorname)%(color:reset) - %(contents:subject) (%(color:green)%(committerdate:relative)%(color:reset))'";
      # List local branches
      bl = "branches refs/heads";
      # List remote branches
      br = "branches refs/remotes";
      # Most recently used branches
      mru = "for-each-ref --count=25 --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
      # Fuzzy find a branch with FZF
      find-branch = "!git branches | fzf --ansi --preview-window=top:60% --preview='echo {} | cut -d\" \" -f3 | xargs -n 1 -t git show | delta --width 240' | cut -d' ' -f3 | sed 's/^origin\\///'";
      # Fuzzy find a commit hash with FZF
      find-hash = "!git graph-log | fzf --ansi --no-sort --reverse --preview-window top:60% --preview='echo {} | rg -o \"\\b[a-f0-9]{7,}\\b\" | xargs -t git show | delta --width 240' | rg -o '\\b[a-f0-9]{7,}\\b'";
      # Fuzzy find and checkout a branch
      fc = "!git find-branch | xargs git checkout";
      # Fuzzy find all branches and checkout a branch
      fac = "!git fetch && git find-branch | xargs git checkout";
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        syntax-theme = "Solarized (Light)";
        decorations = {
          commit-decoration-style = "bold purple box ul";
          file-style = "bold purple ul";
          file-decoration-style = "none";
          hunk-header-decoration-style = "black box ul";
        };
        line-numbers = {
	      line-numbers-left-style = "black";
	      line-numbers-right-style = "black";
	      line-numbers-minus-style = "124";
	      line-numbers-plus-style = "28";
        };
      };
    };
    extraConfig = {
      core = {
        autocrlf = "input";
        trustctime = false;
        editor = "nvim";
        filemode = false;
        pager = "${pkgs.gitAndTools.delta}/bin/delta";
      };
      init = {
        defaultBranch = "main";
      };
      interactive = {
        diffFilter = "${pkgs.gitAndTools.delta}/bin/delta --color-only";
      };
      push = {
        default = "upstream";
      };
      pull = {
        ff = "only";
      };
      color = {
        ui = true;
      };
      diff = {
	    tool = "nvim";
        conflictstyle = "diff2";
	    algorithm = "patience";
	    indentHeuristic = true;
	    compactionHeuristic = true;
	    colorMoved = "default";
      };
      merge = {
        tool = "nvim";
        conflictstyle = "diff3";
        algorithm = "patience";
        indentHeuristic = true;
        compactionHeuristic = true;
      };
      difftool = {
        prompt = false;
        trustexitcode = true;
        nvim = {
          cmd = "nvim -d $LOCAL $REMOTE";
        };
      };
      mergetool = {
        prompt = false;
        trustexitcode = true;
        keepBackup = false;
        keepTemporaries = false;
        nvim = {
          cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c 'wincmd b' -c 'wincmd J'";
        };
      };
      commit = {
        template = "~/.git-commit-template";
        verbose = true;
      };
      safe = {
        directory = "~/Tools/neovim";
      };
    };
    ignores = [
      "*.swp"
      ".prettier_d"
      ".eslintcache"
      ".DS_Store"
    ];
    includes = [
      {
        condition = "gitdir:~/Development/Seccl";
        contents = {
          user = {
            email = "luke.xaviersymington@seccl.tech";
            signingkey = "1D83A54F7678F650";
          };
          commit = {
            gpgSign = true;
          };
        };
      }
    ];
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "${pkgs.vim}/bin/vim";
      pager = "${pkgs.delta}/bin/delta";
    };
  };
  programs.ssh = {
    enable = true;
    matchBlocks = {
      Seccl = {
        hostname = "github.com";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "~/.ssh/seccl_rsa";
      };
      Personal = {
        hostname = "github.com";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "~/.ssh/seccl_rsa";
      };
    };
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.tmux = {
    enable = true;
    extraConfig = lxs_tmux_config;
    aggressiveResize = true;
    baseIndex = 1;
    keyMode = "vi";
    historyLimit = 50000;
    prefix = "C-a";
    terminal = "tmux256-color";
    plugins = with pkgs.tmuxPlugins; [
      cpu
      net-speed
      open
      pain-control
      sensible
      vim-tmux-focus-events
      yank
      {
        plugin = continuum;
        extraConfig = ''
          # Enable tmux continuum
          set -g @continuum-restore 'on'
          # Set tmux continuum interval in minutes
          set -g @continuum-save-interval '5'
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          # Restore contents for panes
          set -g @resurrect-capture-pane-contents 'on'
          # Restore contents for vim
          set -g @resurrect-strategy-vim 'session'
          # Restore contents for neovim
          set -g @resurrect-strategy-nvim 'session'
          # Restore using Startify
          set -g @resurrect-processes '"nvim->nvim +SLoad"'
        '';
      }
      (mkTmuxPlugin {
       pluginName = "simple-git-status";
       version = "master";
       src = pkgs.fetchFromGitHub {
        owner = "kristijanhusak";
        repo = "tmux-simple-git-status";
        rev = "287da42f47d7204618b62f2c4f8bd60b36d5c7ed";
        sha256 = "04vs4afxcr118p78mw25nnzvlms7pmgmi2a80h92vw5pzw9a0msq";
       };
      })
    ];
  };
  programs.tealdeer.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
