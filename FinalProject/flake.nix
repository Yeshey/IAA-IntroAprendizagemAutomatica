# https://github.com/nix-community/dream2nix/tree/main

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = { systems, nixpkgs, ... } @ inputs:
  let
    eachSystem = f:
      nixpkgs.lib.genAttrs (import systems) (
        system:
          f nixpkgs.legacyPackages.${system}
      );
  in {
    devShells = eachSystem (pkgs: 
    let

    in {
      default = pkgs.mkShell {
        packages = [
          #pkgs.jupyter-all
          (pkgs.python311.withPackages (python-pkgs: with python-pkgs; [
            tensorflow
            pandas
            numpy
            jupyter
            matplotlib
            scikit-learn
            seaborn
            pkgs.texlive.combined.scheme-full  # Full TeX Live installation
            pkgs.texlivePackages.luatex       # Add luatex support
          ]))
        ];

        shellHook = ''
          echo "Development shell ready!"
          echo "Run with > jupyter notebook"

          # jupyter notebook
        '';
      };
    });
  };
}

