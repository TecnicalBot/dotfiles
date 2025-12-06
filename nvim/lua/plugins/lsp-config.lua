return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "html", "tailwindcss", "gopls", "pyright", "jinja_lsp" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            local servers = { "lua_ls", "ts_ls", "html", "tailwindcss", "gopls", "pyright", "jinja_lsp" }

            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                })
            end

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                init_options = {
                    preferences = {
                        importModuleSpecifierPreference = "non-relative", -- <== KEY
                        importModuleSpecifierEnding = "auto",
                    },
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf

                    local opts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, { silent = true })

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                end,
            })
        end,
    },
}
