{ config, pkgs, ... }:

{
  networking = {
    firewall.allowedTCPPorts = [
      # Allow spotify To sync local tracks from your filesystem with mobile
      # devices in the same network
      57621
      # GS connect
      1716
    ];
  };

  services.urxvtd.enable = true;

  services.dbus.packages = with pkgs; [ gnome3.pomodoro ];

  home-manager.users.panurg = { pkgs, config, lib, ... }: {
    imports = [
      ./dconf.nix
    ];

    gtk = {
      enable = true;
      theme = {
        package = pkgs.numix-gtk-theme;
        name = "Numix";
      };
      iconTheme = {
        package = pkgs.numix-icon-theme-circle;
        name = "Numix-Circle";
      };
      gtk2.extraConfig = ''
        style "vimfix" {
          bg[NORMAL] = "#282828"
        }
        widget "vim-main-window.*GtkForm" style "vimfix"
      '';
    };

    xsession.pointerCursor = {
      package = pkgs.numix-cursor-theme;
      name = "Numix-Cursor";
      size = 48;
    };

    home.packages = with pkgs; let
      pop-shell-shortcuts = callPackage ../packages/pop-shell-shortcuts { };
      pop-shell = callPackage ../packages/pop-shell { inherit pop-shell-shortcuts; };
      pomodoro = gnome3.pomodoro.overrideAttrs (oldAttrs: rec{
        patches = [
          ../packages/pomodoro/fix-paths.patch
        ];
        postPatch = ''
          substituteInPlace plugins/gnome/extension/utils.js \
            --replace "ExtensionSystem.logExtensionError(Extension.metadata.uuid, " \
                      "log(\"MYPATCH_ERROR:\" + "
          substituteInPlace lib/settings.vala \
            --subst-var-by gschemasCompiled ${glib.makeSchemaPath "$out" "${oldAttrs.pname}-${oldAttrs.version}"}
        '';
      });
    in [
      gnome3.gnome-tweak-tool
      gnome3.evince
      gnome3.dconf-editor
      dconf2nix
      gnomeExtensions.remove-dropdown-arrows
      gnomeExtensions.gsconnect
      gnomeExtensions.sound-output-device-chooser
      pop-shell
      spotify
      slack-dark
      tdesktop
      meld
      pomodoro
      libreoffice
      steam
      darktable
      gimp-with-plugins
      inkscape
      transmission-remote-gtk
      hunspell
      hunspellDicts.en_US-large
      hunspellDicts.ru_RU
    ];

    programs = {
      # TODO: check out autorandr or grobi, broot, beets, browserpass or pass,
      # lorri, keychain, lsd, neovim, noti, ssh, zathura
      # TODO wayland: mako
      chromium = {
        enable = true;
        package = pkgs.chromium.override { enableVaapi = true; };
        extensions = [
          "gphhapmejobijbbhgpjhcjognlahblep" # GNOME Shell integration
        ];
      };
      # dircolors.enable = true;
      # feh.enable = true;
      git.extraConfig.merge.tool = "meld";
      mpv = {
        enable = true;
        scripts = [ pkgs.mpvScripts.mpris ];
        config = {
          hwdec = "auto-safe";
          vo = "gpu";
          profile = "gpu-hq";
        };
      };
      urxvt = {
        enable = true;
        fonts = [
          "xft:PragmataPro Mono:size=12"
          "xft:MesloLGS NF:size=10"
        ];
        scroll.bar.enable = false;
        extraConfig = {
          iconFile = "${pkgs.numix-icon-theme-circle}/share/icons/Numix-Circle/48/apps/utilities-terminal.svg";
          italicFont = "xft:PragmataPro Mono:style=italic:size=12";
          boldItalicFont = "xft:PragmataPro Mono:style=bold italic:size=12";
        };
      };
      emacs = {
        enable = true;
        extraPackages = epkgs: with epkgs; [
          use-package
          all-the-icons
          doom-themes
          evil
          evil-collection
          nix-mode
          # company-nixos-options
          # helm-nixos-options
          # nixpkgs-fmt
          evil-commentary
          magit
          evil-magit # part of evil-collection at 2020-11-24
          evil-exchange
          evil-goggles
          evil-surround
          diff-hl
          helm
          projectile
          helm-projectile
          lsp-mode
          lsp-ui
          lsp-treemacs
          company
          company-flx
          company-posframe
          helpful
          hungry-delete
          which-key
          treemacs
          treemacs-all-the-icons
          treemacs-evil
          treemacs-magit
          treemacs-projectile
          pkgs.python3 # treemacs needs python3
          rainbow-delimiters
          emacs-libvterm
          dired-single
          all-the-icons-dired
          pdf-tools
          saveplace-pdf-view
          flyspell-lazy
          highlight-numbers
          highlight-escape-sequences
          telephone-line
          direnv
        ];
      };
    };

    services = {
      # TODO: check out flameshot, systemd getmail, hound (!!!), redshift, screen-locker
      # spotifyd, syncthing, udiskie, unclutter, XSuspender
    };

    systemd.user.sessionVariables = {
    };

    # TODO: check out wayland configuration: sway
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        desktop = "\$HOME/desktop";
        documents = "\$HOME/doc";
        download = "\$HOME/dl";
        music = "\$HOME/music";
        pictures = "\$HOME/img";
        publicShare = "\$HOME/share";
        templates = "\$HOME/templates";
        videos = "\$HOME/video";
      };
    };

    xresources.properties = {
      "*.foreground" = "#dedede";
      "*.background" = "#444444";
      "*.cursorColor" = "#dedede";

      # black
      "*.color0" = "#555555";
      "*.color8" = "#888888";

      # red
      "*.color1" = "#9c3528";
      "*.color9" = "#d64937";

      # green
      "*.color2" = "#61bc3b";
      "*.color10" = "#86df5d";

      # yellow
      "*.color3" = "#f3b43a";
      "*.color11" = "#fdd75a";

      # blue
      "*.color4" = "#0d68a8";
      "*.color12" = "#0f75bd";

      # magenta
      "*.color5" = "#744560";
      "*.color13" = "#9e5e83";

      # cyan
      "*.color6" = "#288e9c";
      "*.color14" = "#37c3d6";

      # white
      "*.color7" = "#a2a2a2";
      "*.color15" = "#f9f9f9";
    };
  };
}
