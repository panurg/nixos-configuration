{ lib, config, pkgs, ... }:

{
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/GWeather" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [
        "Utilities"
        "6453ad86-79c7-42c2-8fd7-0ae3d542a303"
      ];
    };

    "org/gnome/desktop/app-folders/folders/6453ad86-79c7-42c2-8fd7-0ae3d542a303" = {
      apps = [
        "startcenter.desktop"
        "base.desktop"
        "calc.desktop"
        "draw.desktop"
        "impress.desktop"
        "math.desktop"
        "writer.desktop"
      ];
      name = "Office";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      current = mkUint32(0);
      sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "ru" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "grp:caps_toggle" ];
    };

    "org/gnome/desktop/interface" = {
      clock-show-date = true;
      clock-show-weekday = true;
      cursor-theme = config.xsession.pointerCursor.name;
      cursor-size = config.xsession.pointerCursor.size;
      monospace-font-name = "PragmataPro Mono 12";
      show-battery-percentage = false;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/notifications/application/spotify" = {
      application-id = "spotify.desktop";
      details-in-lock-screen = true;
      force-expanded = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.65;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      report-technical-problems = false;
    };

    "org/gnome/desktop/screensaver" = {
      lock-delay = mkUint32(0);
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32(900);
    };

    "org/gnome/desktop/wm/keybindings" = {
      begin-resize = [ "<Super>r" ];
      close = [ "<Shift><Super>c" ];
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      move-to-workspace-5 = [ "<Super><Shift>5" ];
      move-to-workspace-6 = [ "<Super><Shift>6" ];
      move-to-workspace-7 = [ "<Super><Shift>7" ];
      move-to-workspace-8 = [ "<Super><Shift>8" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      toggle-maximized = [ "<Super>f" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      auto-raise = true;
      focus-mode = "sloppy";
      num-workspaces = 8;
    };

    "org/gnome/eog/view" = {
      transparency = "background";
    };

    "org/gnome/gedit/preferences/editor" = {
      editor-font = "PragmataPro Mono 72";
      scheme = "solarized-light";
      use-default-font = true;
      wrap-last-split-mode = "char";
      wrap-mode = "char";
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      focus-change-on-pointer-rest = true;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Shift><Super>h" ];
      toggle-tiled-right = [ "<Shift><Super>l" ];
    };

    "org/gnome/nautilus/preferences" = {
      click-policy = "double";
      executable-text-activation = "ask";
    };

    "org/gnome/settings-daemon/peripherals/touchscreen" = {
      orientation-lock = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = mkUint32(4360);
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "urxvt";
      name = "Launch terminal";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "hibernate";
      sleep-inactive-ac-type = "blank";
    };

    "org/gnome/settings-daemon/plugins/xsettings" = {
      antialiasing = "rgba";
      hinting = "full";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "remove-dropdown-arrows@mpdeimos.com"
        "freon@UshakovVasilii_Github.yahoo.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "activities-config@nls1729"
      ];
      favorite-apps = [
        "chrome-djeeobknjeechdoljfdmkojhlapmmpnd-Default.desktop"
        "chromium-browser.desktop"
        "slack.desktop"
        "telegramdesktop.desktop"
        "spotify.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Geary.desktop"
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

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "slack.desktop:5"
        "telegramdesktop.desktop:5"
        "spotify.desktop:8"
        "steam.desktop:7"
      ];
    };

    "org/gnome/shell/extensions/freon" = {
      drive-utility = "none";
      group-temperature = true;
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
  };
}