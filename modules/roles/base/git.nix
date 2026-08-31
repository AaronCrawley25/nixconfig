{ self, inputs, ... }: {
  flake.nixosModules.base =
    {
      pkgs,
      lib,
      gitname,
      gitemail,
      ...
    }:
    {
      programs.git.enable = true;

      environment.systemPackages = with pkgs; [
        git-credential-manager
      ];

      services.pcscd.enable = true;

      programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-qt;
      };

      home = {
        programs.git = {
          enable = true;
          settings = {
            user = {
              name = gitname;
              email = gitemail;
            };

            init.defaultBranch = "main";
            pull.rebase = true;
            fetch.prune = true;
            push.autoSetupRemote = true;
            commit.gpgsign = true;
            credential.credentialStore = "cache";
            credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
          };
        };
      };
    };

}
