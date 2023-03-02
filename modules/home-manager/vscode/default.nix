{ self, inputs, config, pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;
      userSettings = {
        "debug.toolBarLocation" = "docked";
        "editor.cursorSurroundingLines" = 5;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.lineHighlightBackground" = "#ffffff0A";
        "editor.renderLineHighlight" = "none";
        "editor.renderLineHighlightOnlyWhenFocus" = true;
        "editor.stickyScroll.enabled" = true;
        "explorer.fileNesting.enabled" = true;
        "explorer.fileNesting.expand" = false;
        "files.insertFinalNewline" = true;
        "git.mergeEditor" = true;
        "githubPullRequests.pushBranch" = "always";
        "githubPullRequests.defaultMergeMethod" = "squash";
        "liveshare.allowGuestDebugControl" = true;
        "liveshare.allowGuestTaskControl" = true;
        "liveshare.guestApprovalRequired" = true;
        "liveshare.joinDebugSessionOption" = "Prompt";
        "liveshare.languages.allowGuestCommandControl" = true;
        "liveshare.launcherClient" = "visualStudioCode";
        "liveshare.presence" = true;
        "merge-conflict.autoNavigateNextConflict.enabled" = true;
        "mochaExplorer.exit" = true;
        "mochaExplorer.pruneFiles" = true;
        "mochaExplorer.timeout" = 3000;
        "scm.diffDecorationsGutterWidth" = 1;
        "search.showLineNumbers" = true;
        "telemetry.telemetryLevel" = "off";
        "terminal.explorerKind" = "external";
        "terminal.external.osxExec" = "Alacritty.app";
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.localEchoStyle" = "dim";
        "testExplorer.addToEditorContextMenu" = true;
        "testExplorer.mergeSuites" = true;
        "testExplorer.onReload" = "retire";
        "testExplorer.onStart" = "retire";
        "testExplorer.showOnRun" = true;
        "testExplorer.sort" = "byLocationWithSuitesFirst";
        "testExplorer.useNativeTesting" = true;
        "typescript.tsdk" = "./node_modules/typescript/lib";
        "vim.argumentObjectClosingDelimiters" = [")" "]" "}"];
        "vim.argumentObjectOpeningDelimiters" = ["(" "[" "{"];
        "vim.cursorStylePerMode.insert" = "line-thin";
        "vim.cursorStylePerMode.normal" = "block";
        "vim.cursorStylePerMode.replace" = "underline";
        "vim.cursorStylePerMode.visual" = "block-outline";
        "vim.cursorStylePerMode.visualblock" = "block-outline";
        "vim.cursorStylePerMode.visualline" = "block-outline";
        "vim.highlightedyank.enable" = true;
        "vim.hlsearch" = true;
        "vim.incsearch" = true;
        "vim.insertModeKeyBindings" = [
          {
            before = ["j" "j"];
            after = ["<Esc>"];
          }
        ];
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            before = ["K"];
            commands = [
              "editor.action.showHover"
            ]; 
          }
          {
            before = ["leader" "@" "d"];
            commands = [
              "editor.action.showDefinitionPreviewHover"
            ]; 
          }
          {
            before = ["leader" "t" "n"];
            commands = [
              "testing.runAtCursor"
            ]; 
          }
          {
            before = ["leader" "t" "f"];
            commands = [
              "testing.runCurrentFile"
            ]; 
          }
          {
            before = ["leader" "t" "d"];
            commands = [
              "testing.debugAtCursor"
            ]; 
          }
          {
            before = ["]" "d"];
            commands = [
              "editor.action.marker.next"
            ];
          }
          {
            before = ["[" "d"];
            commands = [
              "editor.action.marker.prev"
            ];
          }
          {
            before = ["]" "c"];
            commands = [
              "workbench.action.editor.nextChange"
            ];
          }
          {
            before = ["[" "c"];
            commands = [
              "workbench.action.editor.previousChange"
            ];
          }
          {
            before = ["]" "t"];
            commands = [
              "testing.goToNextMessage"
            ];
          }
          {
            before = ["[" "t"];
            commands = [
              "testing.goToPreviousMessage"
            ];
          }
        ];
        "vim.leader" = "<space>";
        "vim.matchpairs" = "(:),{:},[:],<:>";
        "vim.showMarksInGutter" = true;
        "vim.smartRelativeLine" = true;
        "vim.useCtrlKeys" = true;
        "vim.useSystemClipboard" = false;
        "vim.visualstar" = true;
        "window.autoDetectColorScheme" = true;
        "window.nativeTabs" = true;
        "window.newWindowDimensions" = "maximized";
        "window.zoomLevel" = 1;
        "workbench.colorTheme" = "Catppuccin Frappé";
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.preferredDarkColorTheme" = "Catppuccin Frappé";
        "workbench.preferredLightColorTheme" = "Catppuccin Latte";
      };
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "catppuccin-vsc";
          publisher = "Catppuccin";
          version = "2.1.1";
          sha256 = "0x5gnzmn8mzqzf636jzqnld47mbbwml1ramiz290bpylbxvh553h";
        }
      ];
    };
  };
}
