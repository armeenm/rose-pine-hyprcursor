{
  description = "Rose Pine themed BreezeX Cursor for Hyprcursor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, ... }: let
    forAllSystems = f: nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ] (system: f system (
      import nixpkgs { inherit system; }
    ));

  in {
    devShells = forAllSystems (_: pkgs: with pkgs; {
      default = (mkShell {
        packages = [ hyprcursor ];
      });
    });

    packages = forAllSystems (_: pkgs: {
      default = pkgs.callPackage ./default.nix { };
    });

    formatter = forAllSystems (_: pkgs: pkgs.nixfmt-rfc-style);
  };
}
