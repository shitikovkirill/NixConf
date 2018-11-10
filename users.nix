{ config, pkgs, ... }:
{
  users.users.kirill = {
    isNormalUser = true;
    home = "/home/kirill";
    description = "Kirill Shitikov";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    openssh.authorizedKeys.keys =
[
"YMEkqI5IpLqlWubAT/XZOBltCzN3mv0eA2v8Sdh1k2z0lzdUVyi5JtqjsgflVCICRBOz3y7j6SI2yPlajnQpRw4xXLVgKclidswhEaPur9rCQ10Btr3i7cLVd1iBvfiSpNIeDKjiz0ox1DdI5UOnDn39SFZ6twAWHpdj2l5Xgo30+b0JfYz6kjJkgI5qoNVd4a7izGmx7SweRLue3/dJD++ziQoyFP+7Cd2jxBvYTXCV27UFnTC7bXN7o3TbE19NC7JtDKGutY4VxoDw9CRmoqoXnE7L228KQcmdTII2HT7nfoN+98OKxJ8nG7GfcEa5mjcdkCDm8yw1HvITdljhfumJrdHt1PKishbP0uf4LwZwkuYfCK+xaTDwdjsbfO+oydRbCesDTMYhnYo7+S3xt0IC6cRfmUQna1e/55XcSIMikNaMlUy2uKyArV2B/yQXlYsT+ww4pbJbf2fC/iG4uvqEhqdrZo5euMR1NtownrSlslds5k7265MEqdWUKvKIm7wrPzypaRcWGup2DcQBL7om0yoKEIJIj4cBNnaKplvI/GotaeD1hZABmiOctGYpDZkFVR5NRLruw7u03IMgvTVcMv7f8+0WYYBe65mbBiBei5BPHk0zzD5NeVylvGxOnQ==
sh.kiruh2@gmail.com"
];
  };
}
