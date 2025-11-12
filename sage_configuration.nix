# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; ref = "master"; rev = "3a4da5f8c13b542c1298e7f0da6c1767db59602d"; }}/framework/12-inch/13th-gen-intel"
    ];

  # FIXME Phase1
  # Requiers for Intel wifi to work on laptop
  # boot.kernelPackages = pkgs.linuxPackages_5_7;

  # Boot loader (UEFI)
  boot.loader.systemd-boot.configurationLimit = 30;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;
  boot.initrd.luks.devices = {
    root = {
      # FIXME Phase1 Set proper value
      device = "/dev/sda2";
      preLVM = true;
    };
  };
  boot.supportedFilesystems = [ "ntfs" ];

  # ethernet driver for eno1 (ethernet network interface)
  boot.initrd.kernelModules = [ "igc" ];
  boot.initrd.network = {
    enable = true;
    ssh = {
      enable = true;
      port = 2222;
      shell = "/bin/cryptsetup-askpass";
      hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
      authorizedKeys = [
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICiZ/5BJcFcSfSfrfwT1cy52zHQP23F81AoxnB850Yol nixos@Star''
      ];
    };
  };

  # FIXME Phase1 Set proper mount point options
  # Filesystem
  fileSystems = {
    "/".options = [ "compress=zstd:1" ];
    "/nix".options = [ "compress=zstd:1" ];
    "/home".options = [ "compress=zstd:1" ];
    "/data".options = [ "compress=zstd:1" ];
    "/snapshots".options = [ "compress=zstd:1" ];
    "/swap".options = [ "noatime" ];
  };
  swapDevices = [ { device = "/swap/swapfile"; } ];
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/" ];
  };

  # Networking
  networking.useDHCP = false;
  networking.interfaces.yours.useDHCP = true;
  networking.interfaces.yours.wakeOnLan.enable = true;
  networking.networkmanager = {
    enable = true;
    appendNameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
  # FIXME Phase1 Set proper name
  networking.hostName = "nixos";

  networking.firewall = {
    allowedTCPPorts = [
      2025 
      161 162 9100 # HPLIP printing
    ];
    # without 22 git ssh won't work
    allowedUDPPorts = [
      22 51820 # Clients and peers can use the same port, see listenport
      # nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup'
      161 162 9100 # HPLIP printing
    ];
  };
  # VPN
  # WireGuard wg-quick
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.0.0.0/32" ];
      dns = [ "10.3.0.1" ];
      privateKeyFile = "/etc/secrets/wg0.priv";
      peers = [
        {
          publicKey = "pub_key";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "IP4:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # Nix
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    settings.auto-optimise-store = true;
  };

  # Localization
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  time.timeZone = "Europe/London";

  # Sound
  services.pipewire.enable = true;
  # hardware.alsa.enablePersistence = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;

  # hardware.opengl.driSupport32Bit = true;
  nixpkgs.config.allowUnfree = true;

  # Gaming
  services.pulseaudio.support32Bit = true;

  # Dygma Raise
  # network driver for minis
  # Dygma Defy
   services.udev.extraRules =''
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2201", GROUP="users", MODE="0666"
SUBSYSTEM=="drivers", DEVPATH=="/bus/pci/drivers/mt7921e", ATTR{new_id}="14c3 0608"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="35ef", ATTRS{idProduct}=="0012", GROUP="users", MODE="0666"
  '';

  # Services
  services.greenclip.enable = true;
  services.locate.enable = true;
  services.openssh = {
    enable = true;
    extraConfig = ''
ClientAliveInterval 100
'';
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    startWhenNeeded = true;
  };
  services.vnstat.enable = true;
  services.thermald.enable = true;
  # udisksctl
  services.udisks2.enable = true;
  # Printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.hplip ];

  services.tailscale.enable = true;
  # take tailscale pkg from flake inputs
  # services.tailscale.package = inputs.tailscale.packages."${pkgs.system}".tailscale;

  # Scanner
  hardware.sane.enable = true;
  hardware.sane.brscan4.enable = true;
  hardware.bluetooth.enable = true;

  # X
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "mike";
    };
    defaultSession = "none+leftwm";
  };
  # Touchpad support
  services.libinput.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "pl";
      variant = "colemak";
    };
    displayManager.lightdm.enable = true;
    windowManager.leftwm.enable = true;
  };

  system.autoUpgrade = {
    allowReboot = false;
    dates = "weekly";
    enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      # This is needed because Docker cannot resolve localhost DNS lookup
      extraOptions = "--dns 9.9.9.9";
    };
    virtualbox = {
      guest.enable = true;
      host.enable = true;
    };
  };
  # KVM by Virt Manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # users
  # CIFIXME_TEST: do NOT remove, used by CI
  users.users.mike = {
    createHome = true;
    # uucp is needed by Bazecor do flash Dygma keyboards
    extraGroups =
      [ "adbusers" "audio" "disk" "docker" "libvirtd" "networkmanager" "uucp" "vboxsf" "vboxusers" "video" "wheel" ];
    group = "users";
    home = "/home/mike";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIH0uiT3vy0DVxDHI82v1EW/NxteksHexFcKdXHLcc+L nixos@Arrakis''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICiZ/5BJcFcSfSfrfwT1cy52zHQP23F81AoxnB850Yol nixos@Star''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKNfaNgJUXd51qUbNmi6dXYON4rSGIDt4aLhDhIPlh7 osmc@osmc''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILWAyfg5RYzj8s3EV06QN1TPDH597nn63wmh1Q7tYthM xps''
    ];
    # FIXME Phase2 Uncomment once fish is installed using home-manager
    #shell = /home/mike/.nix-profile/bin/fish;
    uid = 1000;
  };

  # Pkgs
  environment.systemPackages = with pkgs; [
    alsa-utils
    android-studio
    appimage-run
    killall
    lynx
    networkmanagerapplet
    steam-run
    wget
    vim
  ];

  # Android
  programs.adb.enable = true;

  programs.bazecor.enable = true;
  programs.command-not-found.enable = true;
  programs.i3lock.enable = true;
  programs.mosh.enable = true;
  # Gaming
  programs.steam.enable = true;

  services.openvpn.servers = {
    hobby = {
      autoStart = false;
      # Remove cipher once the server version is upgraded
      config = ''
        cipher BF-CBC
        config /root/config.ovpn
      '';
    };
  };

  system.stateVersion = "25.05";
}
