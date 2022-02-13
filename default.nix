{
  pkgs ? import <nixpkgs> {
    overlays = [
      (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
    ];
  } 
}:

pkgs.stdenv.mkDerivation {
  name = "fox";
  buildInputs = [
    pkgs.rust-bin.stable.latest.default
  ];
}
