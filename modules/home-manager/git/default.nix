{
  config,
  pkgs,
  ...
}: {
  programs = {
    git = {
      enable = true;

      settings = {
        user = {
          email = "lukexaviersymington@gmail.com";
          name = "Luke Xavier Symington";
        };

        alias = {
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
          # Stash untracked files as well
          sa = "stash --all";
          # Push rewritten history, but more carefully protecting remote refs
          pfwl = "push --force-with-lease";
        };

        branch = {
          sort = "-committerdate";
        };

        core = {
          autocrlf = "input";
          trustctime = false;
          editor = "nvim";
          filemode = false;
          pager = "${pkgs.delta}/bin/delta";
        };

        column = {
          ui = "auto";
        };

        help = {
          autocorrect = "prompt";
        };

        init = {
          defaultBranch = "main";
        };

        interactive = {
          diffFilter = "${pkgs.delta}/bin/delta --color-only";
        };

        push = {
          default = "simple";
          autoSetupRemote = true;
          followTags = true;
        };

        pull = {
          ff = "only";
        };

        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };

        color = {
          ui = true;
        };

        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          compactionHeuristic = true;
          conflictstyle = "diff2";
          indentHeuristic = true;
          mnemonicPrefix = true;
          renames = true;
          tool = "nvimdiff";
        };

        feature = {
          experimental = true;
        };

        merge = {
          tool = "nvimdiff";
          conflictstyle = "zdiff3";
          algorithm = "patience";
          indentHeuristic = true;
          compactionHeuristic = true;
          mergiraf = {
            name = "mergiraf";
            driver = "${pkgs.mergiraf}/bin/mergiraf merge --git %O %A %B -s %S -x %X -y %Y -p %P";
          };
        };

        difftool = {
          prompt = false;
          trustexitcode = true;
          nvimdiff = {
            layout = "LOCAL,REMOTE";
          };
        };

        mergetool = {
          prompt = false;
          trustexitcode = true;
          keepBackup = false;
          keepTemporaries = false;
          nvimdiff = {
            layout = "LOCAL,BASE,REMOTE / MERGED";
          };
        };

        commit = {
          verbose = true;
        };

        rebase = {
          autoSquash = true;
          autoStash = true;
          updateRefs = true;
        };

        rerere = {
          enabled = true;
          autoupdate = true;
        };

        safe = {
          directory = "${config.home.homeDirectory}/Tools/neovim";
        };

        tag = {
          sort = "version:refname";
        };
      };

      attributes = [
        "flake.nix nix"
        ".envrc nix"
        ".direnv nix"
        "*.java merge=mergiraf"
        "*.rs merge=mergiraf"
        "*.go merge=mergiraf"
        "*.js merge=mergiraf"
        "*.jsx merge=mergiraf"
        "*.json merge=mergiraf"
        "*.yml merge=mergiraf"
        "*.yaml merge=mergiraf"
        "*.toml merge=mergiraf"
        "*.html merge=mergiraf"
        "*.htm merge=mergiraf"
        "*.xhtml merge=mergiraf"
        "*.xml merge=mergiraf"
        "*.c merge=mergiraf"
        "*.cc merge=mergiraf"
        "*.h merge=mergiraf"
        "*.cpp merge=mergiraf"
        "*.hpp merge=mergiraf"
        "*.cs merge=mergiraf"
        "*.dart merge=mergiraf"
        "*.scala merge=mergiraf"
        "*.sbt merge=mergiraf"
        "*.ts merge=mergiraf"
        "*.py merge=mergiraf"
      ];

      ignores = [
        "*.swp"
        ".prettier_d"
        ".eslintcache"
        ".DS_Store"
      ];
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        features = "side-by-side line-numbers decorations";
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
  };
}
