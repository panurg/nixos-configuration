{ stdenv, fetchFromGitHub, glib, nodePackages }:

stdenv.mkDerivation rec {
  pname = "pop-shell";
  version = "2020-11-05";

  uuid = "pop-shell@system76.com";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = "9f0976f1f9bf6e3d548fb74fddf86f3c15733311";
    sha256 = "09fgfzdlrjwzqcqzr60jhpxjf37c4x0w28a0j6nsv9njwjmzggm0";
  };

  nativeBuildInputs = [ glib nodePackages.typescript ];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions" ];
}
