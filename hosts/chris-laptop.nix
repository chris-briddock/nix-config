{ config, pkgs, ... }:

let
  dotnetCore = pkgs.dotnetCorePackages;
  dotnetSdks = dotnetCore.combinePackages [
    dotnetCore.sdk_8_0
    dotnetCore.dotnet_9.sdk
  ];
in {
  # Packages
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

  # Docker
  services.docker.enable = true;
  users.extraUsers.chris.extraGroups = [ "docker" ];

  # Optional: Spotify local discovery
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # Locale/time
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
