{ config, pkgs, ... }:
{
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.sami = {
        isNormalUser = true;
        description = "sami";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
    };
}
