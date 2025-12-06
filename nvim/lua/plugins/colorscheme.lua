return {
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
            })
            vim.cmd("colorscheme tokyonight-night")
        end,
    },
}
