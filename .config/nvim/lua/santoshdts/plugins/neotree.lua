return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		{ "-", ":Neotree toggle<CR>", desc = "NeoTree reveal", silent = true },
		vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>"),
	},
	opts = {
		popup_border_style = "",
		window = {
			position = "right",
			width = 30,
		},
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
			},
			window = {
				mappings = {
					["-"] = "close_window",
				},
			},
		},
	},
}
