{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell
{
    nativeBuildInputs = with pkgs.buildPackages; [
      dosbox-staging
      swiProlog
    ];
}
