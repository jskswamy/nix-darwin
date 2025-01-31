{
  description = "Krishnaswamy's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, ghostty }:
  let
    username = "subramk";

    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      environment.shells = [
        pkgs.fish
        "/opt/homebrew/bin/fish"
      ];

      environment.systemPackages =
        [ 
          pkgs.alacritty
          pkgs.any-nix-shell
          pkgs.aria2
          pkgs.bat
          pkgs.bruno
          pkgs.bruno-cli
          pkgs.cocoapods
          pkgs.colima
          pkgs.coreutils
          pkgs.cosign
          pkgs.ctags
          pkgs.devbox
          pkgs.direnv
          pkgs.dnsmasq
          pkgs.docker
          pkgs.docker-compose
          pkgs.dua
          pkgs.eza
          pkgs.fabric-ai
          pkgs.fd
          pkgs.fish
          pkgs.fpp
          pkgs.fzf
          pkgs.gh
          pkgs.git
          pkgs.gitsign
          pkgs.glow
          pkgs.gnupg
          pkgs.go_1_23
          pkgs.golint
          pkgs.gopls
          pkgs.goreleaser
          pkgs.graphviz
          pkgs.heroku
          pkgs.htop
          pkgs.httpie
          pkgs.iina
          pkgs.ipcalc
          pkgs.jc
          pkgs.jdk8
          pkgs.jq
          pkgs.jump
          pkgs.keychain
          pkgs.kube3d
          pkgs.kubectl
          pkgs.kubectx
          pkgs.kubernetes-helm
          pkgs.lazydocker
          pkgs.lazygit
          pkgs.lima
          pkgs.lorri
          pkgs.lunarvim
          pkgs.lefthook
          pkgs.mkcert
          pkgs.neovim
          pkgs.nssTools
          pkgs.ollama
          pkgs.openssh
          pkgs.open-webui
          pkgs.pet
          pkgs.pika
          pkgs.pinentry-curses
          pkgs.pinentry_mac
          pkgs.pipx
          pkgs.ripgrep
          pkgs.rustup
          pkgs.shell-gpt
          pkgs.shfmt
          pkgs.silver-searcher
          pkgs.skim
          pkgs.sops
          pkgs.starship
          pkgs.stern
          pkgs.terraform-ls
          pkgs.terraform-lsp
          pkgs.tig
          pkgs.tldr
          pkgs.television
          pkgs.tmux
          pkgs.tmuxp
          pkgs.tree
          pkgs.vim
          pkgs.virtualenv
          pkgs.vscode
          pkgs.watch
          pkgs.wget
          pkgs.yazi
          pkgs.yubikey-manager
          pkgs.yubikey-personalization
          pkgs.zellij
        ];

      fonts.packages = [
        pkgs.nerd-fonts.caskaydia-cove
      ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
          "fish-shell/fish-beta-4/fish"
        ];
        taps = [
          "fish-shell/fish-beta-4"
        ];
        casks = [
          "appcleaner"
          "canon-eos-utility"
          "capacities"
          "chatgpt"
          "discord"
          "firefox@nightly"
          "ghostty"
          "hyperkey"
          "karabiner-elements"
          "keybase"
          "ollama"
          "raycast"
          "reader"
          "tailscale"
          "veracrypt"
          "wezterm"
          "yubico-yubikey-manager"
          "zen-browser"
          "zoom"
        ];
        masApps = {
          "barbee hide your menu bar icons" = 1548711022;
          "bitwarden" = 1352778147;
          "dropover easy drag and drop" = 1355679052;
          "endel focus relax sleep" = 1346247457;
          "enchanted llm" = 6474268307;
          "homeassistant" = 1099568401;
          "jomo" = 1609960918;
          "kindle" = 302584613;
          "languagetool" = 1534275760;
          "raycast" = 6738274497;
          "session" = 1521432881;
          "whatsapp" = 310633997;
          "whisper transcription" = 1668083311;
          "wipr2" = 1662217862;
          "yubico authenticator" = 1497506650;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.defaults = {
        dock.autohide = true;
      };

      system.defaults.NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = true;
        _HIHideMenuBar = false;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.scaling" = 1.0;
        "com.apple.trackpad.forceClick" = true;
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;

        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };

      system.defaults.menuExtraClock = {
        Show24Hour = false;
        ShowAMPM = true;
        ShowDayOfWeek = true;
        ShowDate = 1;
      };

      system.defaults.trackpad = {
        Clicking = true;
        Dragging = true;
        TrackpadRightClick = true;
        ActuationStrength = 0;
        FirstClickThreshold = 1;
        SecondClickThreshold = 1;
        TrackpadThreeFingerTapGesture = 2;
      };


      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      users.users.subramk.shell = "/opt/homebrew/bin/fish"; #pkgs.fish;
      programs.fish = {
        enable = true;
        useBabelfish = true;
        vendor = {
          config.enable = true;
          completions.enable = true;
          functions.enable = true;
        };
      };

      programs.gnupg = {
        agent.enable = true;
        agent.enableSSHSupport = true;
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      services.lorri.enable = true;

      nix.optimise = {
        automatic = true;
        user = username;
      };

      nix.gc = {
        automatic = true;
      };

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };

    darwinSystem = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = username;
            autoMigrate = true;
          };
        }
      ];
    };
  in
  {
    darwinConfigurations."Krishnaswamys-M2" = darwinSystem;
    darwinConfigurations."krishnaswamy-m1-pro" = darwinSystem;
    darwinConfigurations."Krishnaswamys-MacBook-Pro-2" = darwinSystem;
  };
}
