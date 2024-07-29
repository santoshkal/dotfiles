return {
	"epwalsh/obsidian.nvim",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},
	version = "*", -- recommended, use latest release instead of latest commit
	keys = {
		{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "[O]bsidian [n]ew note" },
		{ "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "[O]bsidian [O]pen" },
		{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "[O]bsidian [S]earch" },
		{ "<leader>otd", "<cmd>ObsidianToday<cr>", desc = "[O]bsidian [t]o[d]ay" },
	},
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		-- "BufReadPre ~/devops-vault/devops/**.md",
		-- "BufNewFile ~/devops-vault/devops/**.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "my-valut",
				path = "~/devops-vault/devops",
			},
		},
		-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
		-- way then set 'mappings = {}'.
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
		completion = {
			-- Set to false to disable completion.
			nvim_cmp = true,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},
		new_notes_location = "00-Inbox",
		wiki_link_func = function(opts)
			return require("obsidian.util").wiki_link_id_prefix(opts)
		end,

		-- Optional, customize how markdown links are formatted.
		markdown_link_func = function(opts)
			return require("obsidian.util").markdown_link(opts)
		end,
		-- see below for full list of options 👇
		--
		-- Either 'wiki' or 'markdown'.
		preferred_link_style = "wiki",

		-- Optional, for templates (see below).
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},

		-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
		-- URL it will be ignored but you can customize this behavior here.
		---@param url string
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			vim.fn.jobstart({ "open", url }) -- Mac OS
			-- vim.fn.jobstart({"xdg-open", url})  -- linux
			-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
		end,

		-- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
		-- file it will be ignored but you can customize this behavior here.
		---@param img string
		follow_url_func = function(img)
			vim.fn.jobstart({ "qlmanage", "-p", img }) -- Mac OS quick look preview
			-- vim.fn.jobstart({"xdg-open", url})  -- linux
			-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
		end,
		open_notes_in = "vsplit",
	},
}
