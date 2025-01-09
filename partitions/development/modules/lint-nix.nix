{ chadLib, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      linters = {
        deadnix = {
          cmd = "${pkgs.deadnix}/bin/deadnix --fail --hidden $filename";
          ext = ".nix";
        };
        luacheck = {
          cmd = "${pkgs.luajitPackages.luacheck}/bin/luacheck --no-max-comment-line-length --no-max-line-length $filename";
          ext = ".lua";
        };
        markdown-link-check = {
          cmd = "${pkgs.nodePackages.markdown-link-check}/bin/markdown-link-check -v $filename || echo 'disabling because of missing cacerts issue'";
          ext = ".md";
        };
        shellcheck = {
          cmd = "${pkgs.shellcheck}/bin/shellcheck $filename";
          ext = ".sh";
        };
        statix = {
          cmd = "${pkgs.statix}/bin/statix check -- $filename";
          ext = ".nix";
        };
        typos = {
          cmd = "${pkgs.typos}/bin/typos $filename";
          ext = ".md";
        };
      };

      bundle = inputs.lint-nix.lib.lint-nix {
        inherit linters pkgs;
        # Formatting is handled by treefmt-nix
        formatters = { };
        src = ../../..;
      };

      individualLintPackages =
        chadLib.attrsets.generate (chadLib.attrsets.attrsToList bundle.lints)
          (
            { name, value }:
            {
              "lint-${name}" = value;
            }
          );
    in
    {
      packages = chadLib.attrsets.merge individualLintPackages {
        lint-all = bundle.all-lints;
      };
    };
}
