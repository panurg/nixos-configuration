{ stdenv, fetchFromGitHub, glib, nodePackages, pop-shell-shortcuts, gjs }:

stdenv.mkDerivation rec {
  pname = "pop-shell";
  version = "2021-03-16";

  uuid = "pop-shell@system76.com";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = "77650a9aafa2f7adc328424e36dc91705411feb4";
    sha256 = "0dff8gl83kx2qzzybk9hxbszv9p8qw8j40qirvfbx6mly7sqknng";
  };

  patches = [
    ./fix-gjs.patch
  ];

  postPatch = ''
    substituteInPlace src/panel_settings.ts \
      --replace "pop-shell-shortcuts" \
                "${pop-shell-shortcuts}/bin/pop-shell-shortcuts"
  '';

  nativeBuildInputs = [ glib nodePackages.typescript gjs ];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions PLUGIN_BASE=$(out)/share/pop-shell/launcher SCRIPTS_BASE=$(out)/share/pop-shell/scripts" ];

  postInstall = ''
    chmod +x $out/share/gnome-shell/extensions/pop-shell@system76.com/floating_exceptions/main.js
    chmod +x $out/share/gnome-shell/extensions/pop-shell@system76.com/color_dialog/main.js
  '';
}
