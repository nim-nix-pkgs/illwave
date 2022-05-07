{
  description = ''A cross-platform terminal UI library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."illwave-master".dir   = "master";
  inputs."illwave-master".owner = "nim-nix-pkgs";
  inputs."illwave-master".ref   = "master";
  inputs."illwave-master".repo  = "illwave";
  inputs."illwave-master".type  = "github";
  inputs."illwave-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."illwave-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}