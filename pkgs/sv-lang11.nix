# Copyright lowRISC Contributors.
# SPDX-License-Identifier: MIT
{pkgs}:
pkgs.sv-lang.overrideAttrs (prev: rec {
  version = "11.0";
  src = pkgs.fetchFromGitHub {
    owner = "MikePopoloski";
    repo = "slang";
    rev = "v${version}";
    sha256 = "sha256-popHzwX0qwv2POAl7/qX3e//OwJRXGtSl9xogpSn2LI=";
  };

  # Upstream has a patch for mimalloc, which we aren't using.
  postPatch = "";

  # Detrimental when using sv-lang as library.
  cmakeFlags =
    prev.cmakeFlags
    ++ [
      "-DSLANG_USE_MIMALLOC=OFF"
    ];

  # Needed by dependent project.
  propagatedBuildInputs =
    (prev.propagatedBuildInputs or [])
    ++ [
      pkgs.fmt
    ];

  doCheck = false;
})
