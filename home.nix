{ config, pkgs, ... }:
{

    home-manager.users.sami = { pkgs, ... }: {

        home.packages = with pkgs; [
            kitty
            pure-prompt
            kdePackages.kate
            vscode
            neovim
            discord
            insomnia
            postman
        ];


        programs.zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;


            initExtra = ''
                fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
                autoload -U promptinit; promptinit
                prompt pure

                nconf() {
                    sudo nvim "$HOME/nixos-config/''${1:-configuration}.nix"
                }
                _nconf() {
                    local -a nix_files=($HOME/nixos-config/*.nix(:t:r))
                    _describe 'nix_files' nix_files
                }
                compdef _nconf nconf
            '';


            shellAliases = {
                ll = "ls -l -a --color";

                hyconf = "sudo nvim ~/.config/hypr/hyprland.conf";

                # nconf = "sudo nvim \"$HOME/nixos-config/\"\${1:-configuration}\".nix\"";

                rebuild = "sudo nixos-rebuild switch";
                UU = "sudo nixos-rebuild switch --upgrade";
                cleanup = "sudo nix-collect-garbage -d && sudo nix-env --delete-generations old";
            };
        };

        programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        };

        nixpkgs.config.allowUnfree = true;


        programs.home-manager.enable = true;

        home.sessionVariables = {
        EDITOR = "vim";
        };


        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        home.stateVersion = "24.05"; # Please read the comment before changing.

    };
}
