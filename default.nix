let
 pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/30c9efeef01e2ad4880bff6a01a61dd99536b3c9.tar.gz") {};
     
  system_packages = builtins.attrValues {
    inherit (pkgs) 
      glibcLocales
      nix
      podman;
  } ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.vfkit ]
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [ pkgs.qemu ];
  
in

pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  buildInputs = [ system_packages ];
}
