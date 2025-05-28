{ config, pkgs, ... }:
{

    home-manager.users.sami = { pkgs, ... }: {

        home.packages = with pkgs; [
            pure-prompt
            kdePackages.kate
            vscode
            neovim
            discord
            insomnia
            postman
            spotify
	    stremio
            wofi
            waybar
            foot
            kitty
            hyprpolkitagent
	    kdePackages.qtmultimedia
	    qbittorrent
		# gaming
		prismlauncher

		# programming stuff
		gnumake 
		gcc
		cmake
		staruml
		binutils
		sfml
		
		# sfml
		freetype
  		xorg.libX11
  		xorg.xrandr
  		libGL
  		flac
  		libogg
  		libvorbis
  		openal
	];
	
	programs.bottom.enable = true;

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

                # Config checker
                check() {
                  find "''${1:-$HOME/nixos-config}" -name "*.nix" | while read -r file; do
                    echo "Checking: $file"
                    if nix-instantiate --eval "$file" >/dev/null 2>&1; then
                      echo "  [PASS]"
                    else
                      echo "  [FAIL]"
                      nix-instantiate --eval --show-trace "$file" 2>&1 | sed 's/^/    /'
                    fi
                  done
                }
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
