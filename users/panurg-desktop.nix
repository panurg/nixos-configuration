{ config, pkgs, ... }:

{
  networking = {
    firewall.allowedTCPPorts = [
      # Allow spotify To sync local tracks from your filesystem with mobile
      # devices in the same network
      57621
    ];
  };

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

    home.packages = with pkgs; [
      gnome3.gnome-tweak-tool
      gnome3.evince
      gnome3.dconf-editor
      dconf2nix
      gnomeExtensions.remove-dropdown-arrows
      spotify
      slack-dark
      tdesktop
      meld
      gnome3.pomodoro
      libreoffice
      steam
      darktable
      gimp
      inkscape
    ];

    programs = {
      # TODO: check out autorandr or grobi, broot, beets, browserpass or pass,
      # lorri, keychain, lsd, neovim, noti, ssh, zathura
      # TODO wayland: mako
      chromium = {
        enable = true;
        package = pkgs.chromium.override { enableVaapi = true; };
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
