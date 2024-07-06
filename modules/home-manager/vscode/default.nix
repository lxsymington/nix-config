{ inputs, pkgs, ... }:

let
  marketplace_extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    # postman.postman-for-vscode
    # sonarsource.sonarlint-vscode
    amazonwebservices.aws-toolkit-vscode
    antfu.icons-carbon
    antfu.theme-vitesse
    ast-grep.ast-grep-vscode
    asvetliakov.vscode-neovim
    biomejs.biome
    editorconfig.editorconfig
    eg2.tslint
    equinusocio.moxer-icons
    esbenp.prettier-vscode
    github.copilot
    github.copilot-chat
    github.vscode-github-actions
    github.vscode-pull-request-github
    hashicorp.terraform
    hbenl.vscode-mocha-test-adapter
    hbenl.vscode-test-explorer
    hbenl.vscode-test-explorer-liveshare
    jacobpfeifer.pfeifer-hurl
    maty.vscode-mocha-sidebar
    mkhl.direnv
    mongodb.mongodb-vscode
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-wsl
    ms-vscode-remote.vscode-remote-extensionpack
    ms-vscode.remote-explorer
    ms-vscode.remote-server
    ms-vscode.test-adapter-converter
    ms-vsliveshare.vsliveshare
    mvllow.rose-pine
    mxsdev.typescript-explorer
    mylesmurphy.prettify-ts
    orta.vscode-jest
    remcohaszing.schemastore
    sainnhe.everforest
    sdras.night-owl
    tamasfe.even-better-toml
    wallabyjs.quokka-vscode
    yoavbls.pretty-ts-errors
  ];
in
{
  programs = {
    vscode = {
      userSettings = {
        "accessibility.dimUnfocused.enabled" = true;
        "accessibility.dimUnfocused.opacity" = 0.25;

        "aws.samcli.lambdaTimeout" = 90000;

        "debug.toolBarLocation" = "floating";

        "diffEditor.experimental.useVersion2" = true;
        "diffEditor.experimental.collapseUnchangedRegions" = true;
        "diffEditor.experimental.showMoves" = true;
        "diffEditor.hideUnchangedRegions.enabled" = true;

        "editor.codeActionWidget.includeNearbyQuickfixes" = true;
        "editor.cursorSurroundingLines" = 5;
        "editor.fontFamily" = "Rec Mono Duotone, CommitMono, JetBrainsMono Nerd Font, monospace";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 12;
        "editor.formatOnSave" = true;
        "editor.inlayHints.fontSize" = 8;
        "editor.inlayHints.padding" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.lineHighlightBackground" = "#ffffff0A";
        "editor.minimap.autohide" = true;
        "editor.multiDocumentOccurencesHighlight" = true;
        "editor.renderLineHighlight" = "none";
        "editor.renderLineHighlightOnlyWhenFocus" = true;
        "editor.smoothScrolling" = true;
        "editor.stickyScroll.enabled" = true;

        "everforest.diagnosticTextBackgroundOpacity" = "12.5%";
        "everforest.italicKeywords" = true;

        "explorer.fileNesting.enabled" = true;
        "explorer.fileNesting.expand" = false;

        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
          "mongodb.mongodb-vscode" = 1;
          "orta.vscode-jest" = 1;
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

        "jest.runMode" = "deferred";

        "liveshare.allowGuestDebugControl" = true;
        "liveshare.allowGuestTaskControl" = true;
        "liveshare.focusBehavior" = "prompt";
        "liveshare.guestApprovalRequired" = true;
        "liveshare.joinDebugSessionOption" = "Prompt";
        "liveshare.languages.allowGuestCommandControl" = true;
        "liveshare.launcherClient" = "visualStudioCode";
        "liveshare.presence" = true;
        "liveshare.publishWorkspaceInfo" = true;

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

        "vscode-neovim.neovimClean" = true;
        "vscode-neovim.revealCursorScrollLine" = false;

        "window.autoDetectColorScheme" = true;
        "window.commandCenter" = true;
        "window.density.editorTabHeight" = "compact";
        "window.nativeTabs" = false;
        "window.newWindowDimensions" = "maximized";
        "window.titleBarStyle" = "custom";
        "window.zoomLevel" = 1;

        "workbench.activityBar.location" = "top";
        "workbench.colorTheme" = "Rosé Pine";
        "workbench.fontAliasing" = "auto";
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.list.smoothScrolling" = true;
        "workbench.iconTheme" = "moxer-icons";
        "workbench.preferredDarkColorTheme" = "Rosé Pine";
        "workbench.preferredLightColorTheme" = "Rosé Pine Dawn";
        "workbench.productIconTheme" = "icons-carbon";
      };
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        dbaeumer.vscode-eslint
        eamodio.gitlens
      ] ++ marketplace_extensions;
    };
  };
}
