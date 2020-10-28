{ stdenv, fetchFromGitHub, glib, nodePackages }:

stdenv.mkDerivation rec {
  pname = "pop-shell";
  version = "2020-10-16";

  uuid = "pop-shell@system76.com";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = "a11d3c34db01987bb716b8b127b2b889130a4fc1";
    sha256 = "0wyx9yg6afxh7cqirarcbsqmqqdfhrxwqnafjdxxsn4aywajx5p8";
  };

  nativeBuildInputs = [ glib nodePackages.typescript ];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions" ];
}
