{ nur, ... }:
let
  nur-overlay = nur.overlay;
  nvchad-overlay = final: prev:
    {
      nvchad = prev.callPackage ../packages/nvchad { };
    };
in
[
  nur-overlay
  nvchad-overlay
]
