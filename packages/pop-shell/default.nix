{ stdenv, fetchFromGitHub, glib, nodePackages, pop-shell-shortcuts }:

stdenv.mkDerivation rec {
  pname = "pop-shell";
  version = "2020-11-13";

  uuid = "pop-shell@system76.com";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = "e1a9db9f948c092c3d47850370fc3bb69a581d11";
    sha256 = "0yv8gjimiix9bzk7k1plbwfvn5kxc3z5ndqv9j5y42d4g7yk498y";
  };

  postPatch = ''
    substituteInPlace src/panel_settings.ts \
      --replace "pop-shell-shortcuts" \
                "${pop-shell-shortcuts}/bin/pop-shell-shortcuts"
  '';

  nativeBuildInputs = [ glib nodePackages.typescript ];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions" ];
}
