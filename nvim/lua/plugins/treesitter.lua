return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "javascript", "bash" },
            auto_install = false,
            highlight = {
                enable = true,
            },
        })
    end,
}
