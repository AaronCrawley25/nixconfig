{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.base =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
      };

      users.defaultUserShell = pkgs.zsh;

      programs.bat.enable = true;

      environment.systemPackages = with pkgs; [
        fastfetch
      ];

      home = {
        programs.zsh = {
          enable = true;

          autosuggestion = {
            enable = true;
            strategy = [
              "completion"
              "history"
            ];
          };

          history = {
            path = "${config.home-manager.users.aaron.home.homeDirectory}/.zsh_history";
            size = 1000;
            save = 1000;
          };

          completionInit = ''
            autoload -Uz compinit
            zstyle ':completion:*' menu select # Enable menu
            zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}" # Coloured menu
            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive completion
            zmodload zsh/complist
            compinit
            _comp_options+=(globdots) # Add hidden files to tab completion
            unsetopt LIST_BEEP # Disable the tab complete beep
          '';

          shellAliases = {
            ls = "ls --color=auto --group-directories-first";
            la = "ls -a";
            ll = "ls -lah";
            lr = "ls -lRh";
            grep = "grep --color=auto";
            ip = "ip --color=auto";
            "cd.." = "cd ..";
            ssh = "kitten ssh"; # SSH doesn't work with kitty by default, so we doin' this instead
            k = "kubectl";
            kns = "kubens";
            kat = "bat -pp -l yaml";
            less = "bat -p --paging=always";
            cat = "bat -pp";
            vim = "nvim";
            nv = "nvim";
            nix-shell = "nix-shell --run zsh";
          };

          sessionVariables = {
            GPG_TTY = "$(tty)";
            MANPAGER = "sh -c 'col -bx | bat -l man -p --paging=always'"; # Use bat as man pager for syntax highlighting!
            MANROFFOPT = "-c";
            USB = "/run/media/$(whoami)";
            SUDO_EDITOR = "/usr/bin/nvim";
            KUBE_EDITOR = "/usr/bin/nvim";
          };

          initContent = lib.mkOrder 1500 ''
            eval "$(oh-my-posh init zsh --config ${config.home-manager.users.aaron.home.homeDirectory}/.config/oh-my-posh/config.json)"

            bindkey '\e[H'  beginning-of-line # Home Key
            bindkey '\e[F'  end-of-line # End Key
            bindkey '\e[3~' delete-char # Delete Key
            bindkey "^[[1;5C" forward-word # Ctrl Right
            bindkey "^[[1;5D" backward-word # Ctrl Left

            alias cls="printf '\033[2J\033[3J\033[1;1H'" # Clears the scrollback buffer too!

            ZSH_AUTOSUGGEST_HISTORY_IGNORE="(cd *)|(ls *)" # Using history here sucks

            autoload -z edit-command-line
            zle -N edit-command-line
            bindkey -M vicmd v edit-command-line
          '';
        };
      };
    };
}
