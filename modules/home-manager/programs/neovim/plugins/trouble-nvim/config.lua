-- luacheck: globals register_debug_mapping

local trouble = require("trouble")

register_debug_mapping("t", trouble.toggle, "window toggle", { mode = "n" })
