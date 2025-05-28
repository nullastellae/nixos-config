{  pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Enable zsh shell
  programs.zsh.enable = true;

   # Install firefox.
  programs.firefox.enable = true;

environment.systemPackages = with pkgs; [
    atool # Extremely important to home-config
    httpie # Extremely important to home-config
    vim
    chromium
    wget
    git
    nil # LSP for nix language
    fira-code
];
}
