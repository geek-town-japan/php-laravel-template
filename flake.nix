{
  description = "php-laravel-template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    mago = pkgs.stdenv.mkDerivation {
      pname = "mago";
      version = "1.14.0";
      src = pkgs.fetchurl {
        url = "https://github.com/carthage-software/mago/releases/download/1.14.0/mago-1.14.0-x86_64-unknown-linux-musl.tar.gz";
        # hash = pkgs.lib.fakeHash;
        hash = "sha256-/OWpPFO4HNYn9X+0WVN/++l1T+AlD3l9+a8W2zqCI10=";
      };
      installPhase = ''
        install -Dm755 mago $out/bin/mago
      '';
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      # https://search.nixos.org/packages?channel=unstable
      packages = with pkgs; [
        git
        docker
        docker-compose
        mago
      ];
    };
  };
}
