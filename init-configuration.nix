# Import this as module in configuration.nix
{ lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/data".options = [ "compress=zstd" ];
    "/snapshots".options = [ "compress=zstd" ];
    "/swap".options = [ "noatime" ];
  };
  swapDevices = [ { device = "/swap/swapfile"; } ];

  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  # Nix
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Localization
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  time.timeZone = "Europe/Warsaw";

  services.pipewire.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Services
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };

  services.udisks2.enable = true;

  # Touchpad support
  services.libinput.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb.layout = "pl";
  services.xserver.xkb.variant = "colemak";
  # services.xserver.windowManager.leftwm.enable = true;

  users.users.mike = {
    createHome = true;
    # uucp is needed by Bazecor do flash Dygma keyboards
    extraGroups =
      [ "adbusers" "audio" "disk" "docker" "libvirtd" "networkmanager" "uucp" "vboxsf" "vboxusers" "video" "wheel" ];
    group = "users";
    home = "/home/mike";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICiZ/5BJcFcSfSfrfwT1cy52zHQP23F81AoxnB850Yol nixos@Star''
    ];
  };

  # Pkgs
  environment.systemPackages = with pkgs; [
    git
    helix
    lynx
    wget
  ];

}
