{ config, pkgs, ... }:

let
  dotnetCore = pkgs.dotnetCorePackages;
  dotnetSdks = dotnetCore.combinePackages [
    dotnetCore.sdk_8_0
    dotnetCore.dotnet_9.sdk
  ];
in {
  # Allow Brave, Spotify, and other unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install packages system-wide
  environment.systemPackages = with pkgs; [
    dotnetSdks
    nodejs
    vscode
    brave
    spotify
    docker
    git
    powershell
    keepassxc
  ];

  # Enable Docker service
  services.docker.enable = true;

  # Add 'chris' to the docker group so you can run docker without sudo
  users.extraUsers.chris.extraGroups = [ "docker" ];

  # Optional: allow Spotify's local discovery features
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # Basic system settings (you probably already have these in your existing config)
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable sound (PulseAudio)
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}