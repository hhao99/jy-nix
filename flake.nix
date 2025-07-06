{
    description = "A simple Nix package for a hypothetical application";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
       flake-utils.lib.eachDefaultSystem( system:
            let 
                pkgs = import nixpkgs {
                    inherit system;
                };
                jupyterPackages = with pkgs; [
                   R
                    
                ];
            in {
                devShells.default = pkgs.mkShell {
                    packages = jupyterPackages;
                    shellHook = ''
                        echo "Welcome to the development shell for the hypothetical application!"
                    '';
                };
            }
        );
}