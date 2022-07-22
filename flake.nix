{
  description = "The Oracle OCI command line";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";                                        
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:                                              
      with import nixpkgs { system = system; };
      rec {
        defaultPackage = pkgs.poetry2nix.mkPoetryApplication {
          projectDir = self;
          overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
            oci = super.oci.overridePythonAttrs (
		old: {
		  src = builtins.fetchTarball {
                    url = "https://files.pythonhosted.org/packages/cd/14/8624d70ce32325a2230a35d031b1941540eecf5f14e6b026271bf15dbd7e/oci-2.75.1.tar.gz";
                    sha256 = "14rhx9q0ffq3i2ymm5zzq2vjzppfng5v7rpd984rnx53a8yvi9bw";
                  };
		}
	    );
          });
        };
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.python
            pkgs.poetry
          ];
        };
      }
    );
}
