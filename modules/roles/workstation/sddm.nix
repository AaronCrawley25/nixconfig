{ self, inputs, ... }: {
  flake.nixosModules.workstation =
    {
      pkgs,
      lib,
      username,
      ...
    }:
    let
      profile = pkgs.stdenvNoCC.mkDerivation {
        name = "profile.jpg";
        src = ./.;
        dontUnpack = true;
        installPhase = ''
          cp $src/profile.jpg $out
        '';
      };
      wallpaper = pkgs.stdenvNoCC.mkDerivation {
        name = "wallpaper.png";
        src = ./.;
        dontUnpack = true;
        installPhase = ''
          cp $src/wallpaper.png $out
        '';
      };
    in
    {
      imports = [
        inputs.silentSDDM.nixosModules.default
      ];
      programs.silentSDDM = {
        enable = true;
        theme = "default";
        backgrounds = {
          theDefault = "${wallpaper}";
        };
        profileIcons = {
          ${username} = "${profile}";
        };
        settings = {
          "LockScreen" = {
            background = "${builtins.baseNameOf wallpaper}";
          };
          "LoginScreen" = {
            background = "${builtins.baseNameOf wallpaper}";
          };
          "LockScreen.Date" = {
            font-family = "CaskaydiaCove NFM";
          };
          "LockScreen.Message" = {
            font-family = "CaskaydiaCove NFM";
          };
          "LoginScreen.LoginArea.Username" = {
            font-family = "CaskaydiaCove NFM";
          };
          "LoginScreen.LoginArea.PasswordInput" = {
            font-family = "CaskaydiaCove NFM";
          };
          "LoginScreen.LoginArea.LoginButton" = {
            font-family = "CaskaydiaCove NFM";
          };
          "LoginScreen.LoginArea.Spinner" = {
            font-family = "CaskaydiaCove NFM";
          };
          "LockScreen.LoginArea.WarningMessage" = {
            font-family = "CaskaydiaCove NFM";
          };
          "LockScreen.MenuArea.Buttons" = {
            font-family = "CaskaydiaCove NFM";
          };
          "LockScreen.MenuArea.Popups" = {
            font-family = "CaskaydiaCove NFM";
          };
          "Tooltips" = {
            font-family = "CaskaydiaCove NFM";
          };
        };
      };
    };
}
