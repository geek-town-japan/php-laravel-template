{
  description = "php-laravel-template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      # https://search.nixos.org/packages?channel=unstable
      packages = with pkgs; [
        git
        docker
        docker-compose
      ];
    };
  };
}
