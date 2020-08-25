{ stdenv, fetchzip, pkgs }:

stdenv.mkDerivation rec {
  name = "pawn";
  version = "3.10.10";
  src = fetchzip {
    url = "https://www.compuphase.com/pawn/pawn-4.0.5749.zip";
    sha256 = "1qj2n0xql2bmgvng7q7xf7113bgi2kqgaq9jp0dmys3nc3vm123f";
    stripRoot = false;
  };
  nativeBuildInputs = with pkgs; [ cmake gcc_multi ];
  installPhase = ''
    mkdir -p $out/bin
    cp pawncc $out/bin
    cp stategraph $out/bin
    cp pawndisasm $out/bin
    cp pawndbg $out/bin
    cp pawnrun $out/bin
  '';
  # cmakeFlags = [
  #   "../source/compiler"
  #   "-DCMAKE_C_FLAGS=-m32"
  #   "-DCMAKE_BUILD_TYPE=Release"
  # ];
  # buildInputs = [ pkgs.cmake ];
  # outputs = [ "lib" "bin" ]
  # buildPhase = ''
  #   mkdir build
  #   cd build
  #   echo $(pwd)
  #   cmake ../source/compiler -DCMAKE_C_FLAGS=-m32 -DCMAKE_BUILD_TYPE=Release
  #   make
  # '';
  # installPhase = ''
  #   mkdir -p $out/bin
  #   cp foo $out/bin
  # '';
}
