{
  inputs,
  lib,
  ...
}:
{
  # Helper functions for creating system / home-manager configurations

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = {
    mkHost =
      {
        hostname,
        username,
        gitname,
        gitemail,
        sshkey ? "",
        modules,
      }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit
            username
            hostname
            gitname
            gitemail
            sshkey
            ;
          inherit (inputs) nixos-raspberrypi;
        };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          (lib.mkAliasOptionModule [ "home" ] [ "home-manager" "users" username ])
          inputs.self.nixosModules.${hostname}
          inputs.self.nixosModules.base
        ]
        ++ modules;
      };
  };
}
