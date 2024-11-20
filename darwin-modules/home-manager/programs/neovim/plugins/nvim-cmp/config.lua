local cmp = require("cmp")

local function setup_nvim_cmp(context) -- luacheck: ignore
    cmp.setup({
        snippet = {
            expand = function(args)
                context.luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-A-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-A-d>"] = cmp.mapping.scroll_docs(4),
            -- C-b (back) C-f (forward) for snippet placeholder navigation.
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ["<C-d>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif context.luasnip.expand_or_jumpable() then
                    context.luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-u>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif context.luasnip.jumpable(-1) then
                    context.luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
        },
    })
end
