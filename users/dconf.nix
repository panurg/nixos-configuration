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
      minimize = [ "<Super>comma" ];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-monitor-down = [];
      move-to-workspace-down = [];
      move-to-workspace-up = [];
      switch-to-workspace-left = [];
      switch-to-workspace-right = [];
      switch-to-workspace-down = [];
      switch-to-workspace-up = [];
      switch-input-source = [];
      switch-input-source-backward = [];
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
      workspaces-only-on-primary = false;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [];
      toggle-tiled-right = [];
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
      screensaver = [ "<Super>Escape" ];
      rotate-video-lock-static = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "urxvtc";
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
        "pop-shell@system76.com"
        "dynamic-panel-transparency@rockon999.github.io"
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

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "slack.desktop:5"
        "telegramdesktop.desktop:5"
        "spotify.desktop:8"
        "steam.desktop:7"
      ];
    };

    "dynamic-panel-transparency" = {
      enable-background-color = true;
      enable-opacity = true;
      enable-text-color = false;
      hide-corners = true;
      maximized-opacity = 255;
      panel-color = [ 43 43 43 ];
      text-shadow = false;
      transition-speed = 500;
      transition-windows-touch = true;
      transition-with-overview = true;
      unmaximized-opacity = 0;
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

    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      gap-inner = mkUint32(6);
      gap-outer = mkUint32(6);
      show-title = false;
      smart-gaps = true;
      tile-by-default = true;
      tile-enter = [ "<Super>Space" ];
      tile-accept = [ "Space" ];
      pop-monitor-left = [ "<Super><Shift><Control>h" ];
      pop-monitor-right = [ "<Super><Shift><Control>l" ];
      hint-color-rgba = mkTuple [240 84 76 1];
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
      open-application-menu = [];
      toggle-message-tray = [ "<Super>v" ];
      toggle-overview = [];
    };
  };
}
