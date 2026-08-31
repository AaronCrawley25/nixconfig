{ self, inputs, ... }: {
  flake.nixosModules.workstation =
    { pkgs, lib, ... }:
    let
      photogimp = pkgs.fetchFromGitHub {
        owner = "Diolinux";
        repo = "Photogimp";
        rev = "3.1";
        sha256 = "sha256-524lsDRmahWXXP9/cfk2ia+7K6xNFTdoYXO8UUsLP/o=";
      };
    in
    {
      environment.systemPackages = with pkgs; [
        gimp-with-plugins
      ];

      home = {
        xdg.configFile."GIMP/3.0" = {
          source = "${photogimp}/.config/GIMP/3.0";
          recursive = true;
        };
      };
    };
}
