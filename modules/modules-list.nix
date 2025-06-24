{ lib }:

builtins.listToAttrs (
  map (modulePath: {
    name = builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf modulePath);
    value = modulePath;
  })
  (
    let
      files = builtins.attrNames (
        lib.filterAttrs
          (name: type: type == "regular" && lib.hasSuffix ".nix" name)
          (builtins.readDir ./modules)
      );
    in
      map (f: ./modules + "/${f}") files
  )
)