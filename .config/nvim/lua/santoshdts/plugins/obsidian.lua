return {
	"obsidian-nvim/obsidian.nvim",
	-- version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- ft = "markdown",
	dependencies = {
		-- required
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"saghen/blink.cmp",
			dependencies = {
				{ "saghen/blink.compat", branch = "main" },
			},
		},
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
				path = "/home/santosh/Dropbox/devops",
				overrides = {
					notes_subdir = "00-Inbox",
				},
			},
		},
		notes_subdir = "00-Inbox",
		completion = {
			nvim_cmp = false,
			blink = true,
			min_chars = 2,
		},
		new_notes_location = "notes_subdir",

		disable_frontmatter = true,

		templates = {
			folder = "templates",
			date_format = "%Y%m%d%H%M",
		},
		picker = {
			name = "fzf-lua",
			note_mappings = {
				new = "<C-x>",
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
