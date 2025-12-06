return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.code_actions.refactoring,
                require("none-ls.diagnostics.eslint"),
            },
        })
        vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
        vim.diagnostic.config({ virtual_text = true })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end,
}
