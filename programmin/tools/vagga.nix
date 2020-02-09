{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ vagga ];

  users.users = {
    kirill = {
      subUidRanges = [{
        startUid = 100000;
        count = 65536;
      }];
      subGidRanges = [{
        startGid = 100000;
        count = 65536;
      }];
    };
  };
}
