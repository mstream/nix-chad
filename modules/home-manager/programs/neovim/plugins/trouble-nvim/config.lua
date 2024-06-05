local function setup_trouble_nvim(context) -- luacheck: ignore
    local trouble = require("trouble")
    context.register_debug_mapping(
        "t",
        trouble.toggle,
        "window toggle",
        { mode = "n" }
    )
end
