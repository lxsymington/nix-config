{ dotfiles, config, pkgs, ... }:

let
  lxs_git_commit_template = builtins.toPath "${dotfiles}/git/.git-commit-template";
in
{
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
      syntax-theme = "TwoDark";
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
      default = "current";
      autoSetupRemote = true;
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
      template = lxs_git_commit_template;
      verbose = true;
    };
    remote = {
      origin = {
        fetch = "+refs/archive/*:refs/archive/*";
      };
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
}
