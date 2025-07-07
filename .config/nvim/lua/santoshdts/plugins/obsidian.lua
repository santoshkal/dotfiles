return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see above for full list of optional dependencies ☝️
	},
	opts = {
		-- Creates a new Note with the title.md format
		note_id_func = function(title)
			return title
		end,

		workspaces = {
			{
				name = "DevOps",
				path = "~/Dropbox/devops/",
				overrides = {
					notes_subdir = "00-Inbox",
				},
			},
		},
		notes_subdir = "00-Inbox",
		completion = {
			-- Enables completion using blink.cmp
			blink = true,
			-- Trigger completion at 2 chars.
			min_chars = 0,
			-- Set to false to disable new note creation in the picker
			create_new = true,
		},
		new_notes_location = "notes_subdir",

		disable_frontmatter = true,

		-- TODO: Fix the syntax for inseting date in 'YYYYMMMMDDHHSS' format to ID.
		-- see below for full list of options 👇
		templates = {
			folder = "templates",
			date_format = "%Y%m%d%H%M",
		},
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
			name = "fzf-lua",
			-- Optional, configure key mappings for the picker. These are the defaults.
			-- Not all pickers support all mappings.
			note_mappings = {
				-- Create a new note from your query.
				new = "<C-x>",
				-- Insert a link to the selected note.
				insert_link = "<C-l>",
			},
		},
		mappings = {
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
			["gd"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
		},
		ui = {
			enabled = false,
		},
	},
}
