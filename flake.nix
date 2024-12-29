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
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      environment.shells = [
        pkgs.fish
      ];

      environment.systemPackages =
        [ 
      	  #pkgs.nodePackages.bash-language-server
      	  #pkgs.nodePackages.dockerfile-language-server-nodejs
      	  #pkgs.nodePackages.typescript-language-server
      	  #pkgs.nodePackages.yaml-language-server
      	  #pkgs.pinentry
      	  #pkgs.rnix-lsp

          pkgs.vim
 	        pkgs.tmux
      	  pkgs.SDL2
      	  pkgs.any-nix-shell
      	  pkgs.aria2
      	  pkgs.bat
      	  pkgs.cocoapods
      	  pkgs.colima
      	  pkgs.coreutils
      	  pkgs.ctags
      	  pkgs.devbox
      	  pkgs.direnv
      	  pkgs.dnsmasq
      	  pkgs.docker
      	  pkgs.docker-compose
      	  pkgs.dua
      	  pkgs.eza
      	  pkgs.fd
      	  pkgs.fish
      	  pkgs.fpp
      	  pkgs.fzf
      	  pkgs.git
      	  pkgs.glow
      	  pkgs.gnupg
      	  pkgs.go_1_23
      	  pkgs.golint
      	  pkgs.gopls
      	  pkgs.goreleaser
      	  pkgs.graphviz
          pkgs.github-cli
      	  pkgs.heroku
      	  pkgs.htop
      	  pkgs.httpie
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
      	  pkgs.mkcert
      	  pkgs.neovim
      	  pkgs.nssTools
      	  pkgs.openssh
      	  pkgs.pet
      	  pkgs.ripgrep
      	  pkgs.rustup
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
      	  pkgs.tldr
      	  pkgs.tmuxp
      	  pkgs.tree
      	  pkgs.vim
      	  pkgs.vscode
      	  pkgs.watch
      	  pkgs.wget
      	  pkgs.zellij
          pkgs.alacritty
          pkgs.bruno
          pkgs.bruno-cli
          pkgs.cosign
          pkgs.fabric-ai
          pkgs.gitsign
          pkgs.iina
          pkgs.pika
          pkgs.pinentry_mac
          pkgs.pinentry-curses
          pkgs.stow
          pkgs.yazi
          pkgs.yubikey-manager
          pkgs.yubikey-personalization
        ];

      fonts.packages = [
        pkgs.nerd-fonts.caskaydia-cove
      ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
        ];
        casks = [
          "appcleaner"
          "chatgpt"
          "capacities"
          "discord"
          "ghostty"
          "firefox@nightly"
          "karabiner-elements"
          "keybase"
          "raycast"
          "reader"
          "tailscale"
          "veracrypt"
          "wezterm"
          "zen-browser"
          "zoom"
          "yubico-yubikey-manager"
        ];
        masApps = {
          "bitwarden" = 1352778147;
          "homeassistant" = 1099568401;
          "jomo" = 1609960918;
          "languagetool" = 1534275760;
          "raycast" = 6738274497;
          "session" = 1521432881;
          "whatsapp" = 310633997;
          "whisper transcription" = 1668083311;
          "wipr2" = 1662217862;
          "yubico authenticator" = 1497506650;
          "dropover easy drag and drop" = 1355679052;
          "barbee hide your menu bar icons" = 1548711022;
          "endel focus relax sleep" = 1346247457;
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
      users.users.subramk.shell = pkgs.fish;
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
        user = "subramk";
      };

      nix.gc = {
        automatic = true;
      };

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Krishnaswamys-M2
    darwinConfigurations."Krishnaswamys-M2" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "subramk";
            autoMigrate = true;
          };
        }
      ];
    };
    darwinConfigurations."krishnaswamy-m1-pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "subramk";
            autoMigrate = true;
          };
        }
      ];
    };
    darwinConfigurations."Krishnaswamys-MacBook-Pro-2" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "subramk";
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
