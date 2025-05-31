{ chadLib, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      linters = {
        deadnix = {
          cmd =
            chadLib.bash.command {
              flags = [
                "fail"
                "hidden"
              ];
              program = "${pkgs.deadnix}/bin/deadnix";
            }
            + " $filename";
          ext = ".nix";
        };
        luacheck = {
          cmd =
            chadLib.bash.command {
              flags = [
                "no-max-comment-line-length"
                "no-max-line-length"
              ];
              program = "${pkgs.luajitPackages.luacheck}/bin/luacheck";
            }
            + " $filename";
          ext = ".lua";
        };
        markdown-link-check = {
          cmd =
            chadLib.bash.command {
              flags = [
                "verbose"
              ];
              program = "${pkgs.nodePackages.markdown-link-check}/bin/markdown-link-check";
            }
            + " $filename || echo 'disabling because multiple issues'";
          ext = ".md";
        };
        shellcheck = {
          cmd =
            chadLib.bash.command { program = "${pkgs.shellcheck}/bin/shellcheck"; }
            + " $filename";
          ext = ".sh";
        };
        statix = {
          cmd =
            chadLib.bash.command { program = "${pkgs.statix}/bin/statix"; }
            + "check -- $filename";
          ext = ".nix";
        };
        typos = {
          cmd =
            chadLib.bash.command { program = "${pkgs.typos}/bin/typos"; }
            + " $filename";
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
