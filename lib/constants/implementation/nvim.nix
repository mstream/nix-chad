chadLib:
let
  modes = chadLib.enum.create {
    mappings = {
      id = {
        command = "c";
        insert = "i";
        normal = "n";
        visual = "v";
      };
    };
    memberNames = [
      "command"
      "insert"
      "normal"
      "visual"
    ];
    name = "vimModes";
  };
in
{
  inherit modes;
}
