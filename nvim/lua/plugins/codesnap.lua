return {
	"mistricky/codesnap.nvim",
	build = "make build_generator",
	config = function()
		require("codesnap").setup({
			mac_window_bar = true,
			save_path = "~/Pictures/Screenshots/code",
			has_breadcrumbs = false,
			bg_theme = "bamboo",
			has_line_number = false,
			watermark = "",
			bg_color = "#535c6800",
			bg_padding = 40,
		})
		vim.keymap.set("x", "<leader>cc", "<cmd>CodeSnap<cr>", { desc = "Save selected code snapshot into clipboard" })
		vim.keymap.set(
			"x",
			"<leader>cs",
			"<cmd>CodeSnapSave<cr>",
			{ desc = "Save selected code snapshot in ~/Pictures/Screenshots/code" }
		)
	end,
}
