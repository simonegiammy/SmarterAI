# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
   channel = "stable-23.11";
  packages = [
    pkgs.nodePackages.firebase-tools
    pkgs.jdk17
    pkgs.unzip
  ];
  idx.extensions = [
    
  
 "Dart-Code.dart-code"
 "Dart-Code.flutter"];
  idx.previews = {
    previews = {
      web = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "web-server"
          "--web-hostname"
          "0.0.0.0"
          "--web-port"
          "$PORT"
        ];
        manager = "flutter";
      };
      android = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "android"
          "-d"
          "emulator-5554"
        ];
        manager = "flutter";
      };
    };
  };
}

