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
		event_handlers = {
			{
				event = "file_open_requested",
				handler = function()
					-- auto close
					-- vim.cmd("Neotree close")
					-- OR
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
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
					["o"] = "noop",
					["oc"] = "noop",
					["od"] = "noop",
					["og"] = "noop",
					["om"] = "noop",
					["on"] = "noop",
					["os"] = "noop",
					["ot"] = "noop",
				},
			},
		},
	},
}
