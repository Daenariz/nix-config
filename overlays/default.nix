{ inputs, ... }:
{
  # forked nix-synix packages accessible through 'pkgs.synix-dev'
  #  synix-dev-packages = final: prev: { synix-dev = inputs.synix-dev.packages."${final.system}"; };

  # nix-synix packages accessible through 'pkgs.synix'
  synix-packages = final: prev: { synix = inputs.synix.packages."${final.system}"; };

  # packages in `pkgs/` accessible through 'pkgs.local'
  local-packages = final: prev: { local = import ../pkgs { pkgs = final; }; };

  # https://nixos.wiki/wiki/Overlays
  modifications =
    final: prev:
    let
      files = [
      ];
      imports = builtins.map (f: import f final prev) files;
    in
    builtins.foldl' (a: b: a // b) { } imports // inputs.synix.overlays.modifications final prev;

  # stable nixpkgs accessible through 'pkgs.stable'
  stable-packages = final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      inherit (prev) config;
    };
  };

  # old-stable nixpkgs accessible through 'pkgs.old-stable'
  old-stable-packages = final: prev: {
    old-stable = import inputs.nixpkgs-old-stable {
      inherit (final) system;
      inherit (prev) config;
    };
  };

  # old-old-stable nixpkgs accessible through 'pkgs.old-old-stable'
  old-old-stable-packages = final: prev: {
    old-old-stable = import inputs.nixpkgs-old-old-stable {
      inherit (final) system;
      inherit (prev) config;
    };
  };

  #  onnx-overlay = final: prev: {
  #      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [(
  #        python-final: python-prev: {
  #          onnxruntime = python-prev.onnxruntime.overridePythonAttrs (
  #            oldAttrs: {
  #              buildInputs = lib.lists.remove pkgs.onnxruntime oldAttrs.buildInputs;
  #            }
  #          );
  #        }
  #      )];
  #    };
}
