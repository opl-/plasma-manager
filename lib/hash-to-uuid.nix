{ ... }:

{

  ##############################################################################
  # Converts a string into a valid UUIDv4 by hashing it.
  hashToUuid = str:
  let
    inherit (builtins) concatStringsSep getAttr hashString substring;
    hashed = hashString "md5" str;
    variantSubstitutions = {
      "0" = "8"; "1" = "9"; "2" = "a"; "3" = "b";
      "4" = "8"; "5" = "9"; "6" = "a"; "7" = "b";
      "8" = "8"; "9" = "9"; "a" = "a"; "b" = "b";
      "c" = "8"; "d" = "9"; "e" = "a"; "f" = "b";
    };
  in
    concatStringsSep "-" [
      (substring 0 8 hashed)
      (substring 8 4 hashed)
      ("4" + (substring 13 3 hashed))
      ((getAttr (substring 16 1 hashed) variantSubstitutions) + (substring 17 3 hashed))
      (substring 20 12 hashed)
    ];

}
