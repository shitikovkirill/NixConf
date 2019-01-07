{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     go
     dep
   ];

   environment.variables = {
     #GOROOT = "${pkgs.go.out}/share/go";
     GOPATH = "~/.local/share/go";
   };
}
