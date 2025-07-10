return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see above for full list of optional dependencies ☝️
	},
	keys = {
		{ "<leader>oo", "<cmd>Obsidian open<CR>", desc = "Open on App" },
		{ "<leader>os", "<cmd>Obsidian search<CR>", desc = "Obsidian Search" },
		{ "<leader>on", "<cmd>Obsidian new<CR>", desc = "New Note" },
		{ "<leader>oN", "<cmd>Obsidian new_from_template<CR>", desc = "New Note (Template)" },
		{ "<leader>o<space>", "<cmd>Obsidian quick_switch<CR>", desc = "Find Files" },
		{ "<leader>ob", "<cmd>Obsidian backlinks<CR>", desc = "Backlinks" },
		{ "<leader>ot", "<cmd>Obsidian tags<CR>", desc = "Tags" },
		{ "<leader>oT", "<cmd>Obsidian template<CR>", desc = "Template" },
		{ "<leader>oL", "<cmd>Obsidian link<CR>", mode = "v", desc = "Link" },
		{ "<leader>oi", "<cmd>Obsidian links<CR>", desc = "Links" },
		{ "<leader>ol", "<cmd>Obsidian link_new<CR>", mode = "v", desc = "New Link" },
		{ "<leader>oe", "<cmd>Obsidian extract_note<CR>", mode = "v", desc = "Extract Note" },
		{ "<leader>ow", "<cmd>Obsidian workspace<CR>", desc = "Workspace" },
		{ "<leader>or", "<cmd>Obsidian rename<CR>", desc = "Rename" },
		-- { prefix .. "i", "<cmd>Obsidian paste_img<CR>", desc = "Paste Image" },
		-- { prefix .. "d", "<cmd>Obsidian dailies<CR>", desc = "Daily Notes" },
	},
	opts = {
		-- Creates a new Note with the title.md format
		note_id_func = function(title)
			return title
		end,

		statusline = {
			enabled = true,
			format = "{{backlinks}} backlinks | {{words}} words",
		},

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
			nvim_cmp = false,
			blink = true,
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
