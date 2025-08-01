{
  lib,
  mkCoqDerivation,
  coq,
  ITree,
  simple-io,
  version ? null,
}:

mkCoqDerivation {
  pname = "itree-io";
  repo = "coq-itree-io";
  owner = "Lysxia";
  inherit version;

  defaultVersion =
    let
      inherit (lib.versions) isLe range;
    in
    lib.switch coq.coq-version (lib.lists.sort (x: y: isLe x.out y.out) (
      lib.mapAttrsToList (out: case: { inherit case out; }) {
        "0.1.1" = range "8.12" "8.19";
      }
    )) null;
  release = {
    "0.1.1".sha256 = "sha256-IFwIj8dxW4jm2gvuUJ8LKZFSJeljp0bsn8fezxY6t2o=";
  };
  releaseRev = v: "v${v}";

  propagatedBuildInputs = [
    ITree
    simple-io
  ];

  meta = {
    description = "Interpret itree in the IO monad of simple-io.";
    license = lib.licenses.mit;
  };
}
