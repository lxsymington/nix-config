{ inputs, pkgs, ... }:

let
  marketplace_extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    antfu.icons-carbon
    antfu.theme-vitesse
    asvetliakov.vscode-neovim
    editorconfig.editorconfig
    equinusocio.moxer-icons
    github.copilot
    github.copilot-chat
    github.copilot-labs
    github.heygithub
    github.vscode-pull-request-github
    hashicorp.terraform
    hbenl.vscode-mocha-test-adapter
    hbenl.vscode-test-explorer
    hbenl.vscode-test-explorer-liveshare
    jacobpfeifer.pfeifer-hurl
    ms-azuretools.vscode-docker
    ms-vscode.test-adapter-converter
    ms-vsliveshare.vsliveshare
    mxsdev.typescript-explorer
    postman.postman-for-vscode
    rome.rome
    sdras.night-owl
    tamasfe.even-better-toml
    wallabyjs.quokka-vscode
    orta.vscode-jest
  ];
in {
  programs = {
    vscode = {
      userSettings = {
        "accessibility.dimUnfocused.enabled" = true;
        "accessibility.dimUnfocused.opacity" = 0.5;

        "debug.toolBarLocation" = "docked";

        "diffEditor.experimental.useVersion2" = true;
        "diffEditor.experimental.collapseUnchangedRegions" = true;
        "diffEditor.experimental.showMoves" = true;
        "diffEditor.hideUnchangedRegions.enabled" = true;

        "editor.cursorSurroundingLines" = 5;
        "editor.fontFamily" = "Rec Mono Duotone, CommitMono, JetBrainsMono Nerd Font, monospace";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 12;
        "editor.formatOnSave" = true;
        "editor.inlayHints.fontSize" = 8;
        "editor.inlayHints.padding" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.lineHighlightBackground" = "#ffffff0A";
        "editor.renderLineHighlight" = "none";
        "editor.renderLineHighlightOnlyWhenFocus" = true;
        "editor.smoothScrolling" = true;
        "editor.stickyScroll.enabled" = true;
        "editor.minimap.autohide" = true;
        

        "explorer.fileNesting.enabled" = true;
        "explorer.fileNesting.expand" = false;

        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };

        "files.insertFinalNewline" = true;

        "git.mergeEditor" = true;

        "githubPullRequests.pushBranch" = "always";
        "githubPullRequests.defaultMergeMethod" = "squash";

        "javascript.inlayHints.enumMemberValues.enabled" = true;
        "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "javascript.inlayHints.parameterNames.enabled" = "all";
        "javascript.inlayHints.parameterTypes.enabled" = true;
        "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "javascript.inlayHints.variableTypes.enabled" = true;
        
        "jest.autoRun" = "off";

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
        "terminal.integrated.persistentSessionScrollback" = 1000;
        "terminal.integrated.scrollback" = 10000;

        "testExplorer.addToEditorContextMenu" = true;
        "testExplorer.mergeSuites" = true;
        "testExplorer.onReload" = "retire";
        "testExplorer.onStart" = "retire";
        "testExplorer.showOnRun" = true;
        "testExplorer.sort" = "byLocationWithSuitesFirst";
        "testExplorer.useNativeTesting" = true;

        "typescript.tsdk" = "./node_modules/typescript/lib";
        "typescript.inlayHints.enumMemberValues.enabled" = true;
        "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "typescript.inlayHints.parameterNames.enabled" = "all";
        "typescript.inlayHints.parameterTypes.enabled" = true;
        "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "typescript.inlayHints.variableTypes.enabled" = true;
        "typescript.tsserver.experimental.enableProjectDiagnostics" = true;

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
            before = ["g" "d"];
            commands = [
              "editor.action.goToSourceDefinition"
            ]; 
          }
          {
            before = ["g" "t"];
            commands = [
              "editor.action.goToTypeDeclaration"
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
          {
            before = ["z" "j"];
            commands = [
              "editor.gotoNextFold"
            ];
          }
          {
            before = ["z" "k"];
            commands = [
              "editor.goToPreviousFold"
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
        "window.commandCenter" = true;
        "window.nativeTabs" = false;
        "window.newWindowDimensions" = "maximized";
        "window.zoomLevel" = 1;

        "workbench.colorTheme" = "Night Owl Light";
        "workbench.fontAliasing" = "auto";
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.list.smoothScrolling" = true;
        "workbench.iconTheme" = "moxer-icons";
        "workbench.preferredDarkColorTheme" = "Night Owl";
        "workbench.preferredLightColorTheme" = "Night Owl Light";
        "workbench.productIconTheme" = "icons-carbon";
      };
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        dbaeumer.vscode-eslint
        eamodio.gitlens
        vscodevim.vim
      ] ++ marketplace_extensions;
    };
  };
}
