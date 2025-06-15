{ lib, pkgs, ... }:

final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [(
        python-final: python-prev: {
          onnxruntime = python-prev.onnxruntime.overridePythonAttrs (
            oldAttrs: {
              buildInputs = lib.lists.remove pkgs.onnxruntime oldAttrs.buildInputs;
            }
          );
        }
      )];
    }
    
