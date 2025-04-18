return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.completion.luasnip,
            },
        })
    end,

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format),
}
