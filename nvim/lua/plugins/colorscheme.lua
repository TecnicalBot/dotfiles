return {
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        priority = 1000,
        config = function()
            require("tokyonight").setup({})
            vim.cmd("colorscheme tokyonight-night")
        end,
    },
}
