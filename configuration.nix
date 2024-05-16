{ config, modulesPath, pkgs, lib, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  services.openssh.enable = true;

  virtualisation.rosetta.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.getty.autologinUser = "will";
  users.users.will = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGq0NvOp8fyKAS3iHPad2Mz6cOVKNBIElLpnHMy9zNve" ];
    extraGroups = [ "wheel" ];
    initialHashedPassword = ""; # no password local login, still need key for ssh
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  environment.systemPackages = with pkgs; [
    neovim
    btop
  ];
}
