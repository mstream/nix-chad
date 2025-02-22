{ chadLib, ... }:
chadLib.enum.create {
  mappings = {
    key = {
      a = "lualine_a";
      b = "lualine_b";
      c = "lualine_c";
      x = "lualine_x";
      y = "lualine_y";
      z = "lualine_z";
    };
  };

  memberNames = [
    "a"
    "b"
    "c"
    "x"
    "y"
    "z"
  ];

  name = "sections";
}
