{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      pass

      htop
      zip
      unzip

      lastpass-cli

      keeweb
      stacker
      composercat
      graphqlplayground
      snipline
      snippetstore
      
      unetbootin
    ];

    imports = [
      ./social.nix
      ./browser.nix
      ./office.nix
    ];

    nixpkgs.config.packageOverrides = super: {
        keeweb = pkgs.callPackage ./custom/KeeWeb {};
        #openlogviewer = pkgs.callPackage ./custom/Logger {};
        stacker = pkgs.callPackage ./custom/Stacker {};
        #dockstation = pkgs.callPackage ./custom/DockStation {};
        composercat = pkgs.callPackage ./custom/Composercat {};
        graphqlplayground = pkgs.callPackage ./custom/GraphQLPlayground {};
        snipline = pkgs.callPackage ./custom/Snipline {};
        snippetstore = pkgs.callPackage ./custom/SnippetStore {};
        vagga = pkgs.callPackage ./custom/Vagga {};
    };
}
