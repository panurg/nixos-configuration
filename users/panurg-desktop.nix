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
    dconf.settings = with lib.hm.gvariant; {
      "org/gnome/desktop/peripherals/touchpad" = {
        speed = 0.65;
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };
      "org/gnome/desktop/input-sources" = {
        current = mkUint32(0);
        sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "ru" ]) ];
        xkb-options = [ "terminate:ctrl_alt_bksp" "grp:caps_toggle" ];
      };
      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
      };
      "org/gnome/desktop/notifications/application/spotify" = {
        application-id = "spotify.desktop";
        details-in-lock-screen = true;
        force-expanded = true;
      };
      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
        show-battery-percentage = false;
        cursor-theme = config.xsession.pointerCursor.name;
        cursor-size = config.xsession.pointerCursor.size;
        monospace-font-name = "PragmataPro Mono 12";
      };
      "org/gnome/desktop/privacy" = {
        report-technical-problems = false;
      };
      "org/gnome/desktop/session" ={
        idle-delay = mkUint32(900);
      };
      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "sloppy";
        num-workspaces = 8;
        auto-raise = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
        begin-resize = [ "<Super>r" ];
        close = [ "<Shift><Super>c" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
        move-to-workspace-6 = [ "<Super><Shift>6" ];
        move-to-workspace-7 = [ "<Super><Shift>7" ];
        move-to-workspace-8 = [ "<Super><Shift>8" ];
        toggle-maximized = [ "<Super>f" ];
      };
      "org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "hibernate";
        sleep-inactive-ac-type = "blank";
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "urxvt";
        name = "Launch terminal";
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = mkUint32(4360);
      };
      "org/gnome/settings-daemon/plugins/xsettings" = {
        antialiasing = "rgba";
        hinting = "full";
      };
      "org/gnome/GWeather" = {
        temperature-unit = "centigrade";
      };
      "org/gnome/gedit/preferences/editor" = {
        editor-font = "PragmataPro Mono 12";
        scheme = "solarized-light";
        use-default-font = true;
      };
      "org/gnome/mutter/keybindings" ={
        toggle-tiled-left = [ "<Shift><Super>h" ];
        toggle-tiled-right = [ "<Shift><Super>l" ];
      };
      "org/gnome/shell" = {
        always-show-log-out = true;
        enabled-extensions = [
          "remove-dropdown-arrows@mpdeimos.com"
          "freon@UshakovVasilii_Github.yahoo.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "activities-config@nls1729"
        ];
      };
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ "<Super>F1" ];
        switch-to-application-2 = [ "<Super>F2" ];
        switch-to-application-3 = [ "<Super>F3" ];
        switch-to-application-4 = [ "<Super>F4" ];
        switch-to-application-5 = [ "<Super>F5" ];
        switch-to-application-6 = [ "<Super>F6" ];
        switch-to-application-7 = [ "<Super>F7" ];
        switch-to-application-8 = [ "<Super>F8" ];
        switch-to-application-9 = [ "<Super>F9" ];
      };
      "org/gnome/shell/extensions/freon" = {
        drive-utility = "none";
        group-temperature = false;
        group-voltage = false;
        hot-sensors = [ "__max__" ];
        panel-box-index = 3;
        position-in-panel = "right";
        show-decimal-value = false;
        show-fan-rpm = false;
        show-icon-on-panel = true;
        show-voltage = false;
        update-time = 30;
      };
      "org/gnome/shell/extensions/auto-move-windows" = {
        application-list = [
          "slack.desktop:5"
          "telegramdesktop.desktop:5"
          "spotify.desktop:8"
          "steam.desktop:7"
        ];
      };
      "org/gnome/shell/extensions/activities-config" = {
        activities-config-button-icon-path = "${pkgs.numix-icon-theme-circle}/share/icons/Numix-Circle/48/apps/distributor-logo-nixos.svg";
        activities-config-button-no-text = true;
        activities-icon-padding = 0;
        activities-icon-scale-factor = 1.4;
        activities-text-padding = 0;
        enable-conflict-detection = true;
        maximized-window-effect = 0;
        panel-background-color-hex-rgb = "#434343"; # Numix base bg color
        panel-hide-rounded-corners = true;
        show-overview = true;
        transparent-panel = 0;
      };
    };
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
    ];
    programs = {
      # TODO: check out autorandr or grobi, broot, beets, browserpass or pass,
      # lorri, keychain, lsd, neovim, noti, ssh, zathura
      # TODO wayland: mako
      chromium = {
        enable = true;
        # package = pkgs.chromium.override { enableVaapi = true; };
      };
      # dircolors.enable = true;
      feh.enable = true;
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
