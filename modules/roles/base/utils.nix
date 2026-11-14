{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.base =
    { pkgs, ... }:
    let
      oopdate = pkgs.writeShellApplication {
        name = "oopdate";

        runtimeInputs = with pkgs; [
          gum
        ];

        text = builtins.readFile ./oopdate.sh;
      };

    in
    {
      environment.systemPackages = with pkgs; [
        lsof
        pciutils
        inetutils
        dnsutils
        file
        tree
        usbutils
        unzip
        ripgrep
        fzf
        htop
        btop
        nix-tree
        tldr
        jq

        (pkgs.writeShellScriptBin "trim-generations" (builtins.readFile ./trim-generations.sh))

        oopdate
      ];

      home = {
        xdg.desktopEntries.oopdate = {
          name = "oopdate";
          exec = "${oopdate}/bin/oopdate";
          terminal = true;
          type = "Application";
          categories = [ "Utility" ];
          icon = "nix-snowflake";
        };
      };
    };
}
