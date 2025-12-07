{ chadLib, documentWidth, ... }:
let
  luaGetCwdSnippet =
    with chadLib.lua.ast;
    functionInvocation {
      function = recordDereference {
        key = string "getcwd";
        record = recordDereference {
          key = string "fn";
          record = identifier "vim";
        };
      };
      parameters = [ ];
    };

  luaLspStatusSnippet =
    with chadLib.lua.ast;
    functionInvocation {
      function = recordDereference {
        key = string "status";
        record = functionInvocation {
          function = identifier "require";
          parameters = [ (string "lsp-status") ];
        };
      };
      parameters = [ ];
    };

in
{
  _blank = "";
  branch = "branch";
  cwd = chadLib.lua.render luaGetCwdSnippet;
  diff = {
    __unkeyed-1 = "diff";
    colored = true;
  };
  encoding = "encoding";
  fileFormat = "fileformat";
  fileName = {
    __unkeyed-1 = "filename";
    file_status = true;
    newfile_status = true;
    path = 1;
    shorting_target = documentWidth;
  };
  fileType = "filetype";
  location = "location";
  lspStatus = chadLib.lua.render luaLspStatusSnippet;
  mode = "mode";
  progress = "progress";
  tabs = "tab";
}
