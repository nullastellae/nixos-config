{ config, pkgs, ... }:

let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {};
in
{
  users.users.sami = {
    packages = with pkgs; [
      unstable.luanti
    ];
  };
}

