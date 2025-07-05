{
    description = "A simple Nix package for a hypothetical application";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                };
            in
            {
                packages.default = pkgs.stdenv.mkDerivation {
                    pname = "myapp";
                    version = "1.0.0";
                    src = ./.;
                    buildInputs = with pkgs; [
                        python3
                        python3Packages.jupyterlab
                      ];
                    installPhase = ''
                        mkdir -p $out/bin
                        cp myapp $out/bin/
                    '';
                };
            });
}