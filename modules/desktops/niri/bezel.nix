{ self, inputs, ... }:
let
  system = "x86_64-linux";
in
{
  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    let
      # Helper function to create a command action
      mkCmd = cmd: {
        action = "command";
        cmd = cmd;
      };
    in
    {
      hardware.uinput.enable = true;

      home = {
        imports = [
          inputs.bezel.homeManagerModules.default
        ];

        services.bezel = {
          enable = true;
          config = {
            zones = {
              left_width = 0.08;
              right_width = 0.08;
              top_height = 0.08;
              bottom_height = 0.0; # So I can click down the bottom
            };

            gestures = {
              right = {
                up = mkCmd "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 5%+";
                down = mkCmd "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 5%-";
              };

              top = {
                left = mkCmd "qs ipc call player previous";
                right = mkCmd "qs ipc call player next";
                tap = mkCmd "qs ipc call player playpause";
              };
            };
          };
        };
      };
    };

  flake.packages.${system}.bezel = inputs.bezel.packages.${system}.default;
}
