{
  description = "A log file analyzer written in rust.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;
    fenix.url = github:nix-community/fenix;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = {self, nixpkgs, fenix, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      rust-package = fenix.packages.${system};
    in
      {
        defaultPackage = pkgs.stdenv.mkDerivation {
          pname = "fox";
          version = "0.0.1";
          src = ./.;
          buildInputs = [
            (rust-package.stable.withComponents [ 
              "cargo"
              "rustc"
              "rustfmt"
              "rust-src"
            ])
            rust-package.rust-analyzer
          ];
        };
      }
    );
}
