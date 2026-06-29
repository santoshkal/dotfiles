return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = { enable = true, mode = "topline", line_numbers = true },
		},
	},
	config = function()
		local ts = require("nvim-treesitter")

		-- Bigfile detection (prevents TS on files > 500KB)
		local function is_bigfile(buf)
			if vim.b[buf].bigfile then
				return true
			end
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			return ok and stats and stats.size > 500 * 1024
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				if is_bigfile(buf) then
					vim.treesitter.highlighter.disable(buf, 0)
				end
			end,
		})

		-- Basic setup (parser install directory)
		ts.setup({})

		-- Install and manage parsers
		local ensure_installed = {
			"csv",
			"dockerfile",
			"gitignore",
			"cue",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"javascript",
			"json",
			"lua",
			"markdown",
			"proto",
			"python",
			"rego",
			"sql",
			"yaml",
		}
		if vim.fn.executable("tree-sitter") == 1 then
			vim.schedule(function()
				pcall(ts.update, nil, { force = false, summary = true })
				pcall(ts.install, ensure_installed, { force = false })
			end)
		end

		-- Tree-sitter based indentation
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "go", "python", "lua", "javascript", "json", "yaml", "proto", "sql", "markdown" },
			callback = function()
				if not is_bigfile(vim.api.nvim_get_current_buf()) then
					vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
				end
			end,
		})

		-- Incremental selection (manual since main branch removed define_modules)
		local incremental_selection = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = "<leader>sc",
			node_decremental = "<C-->",
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				if is_bigfile(buf) then
					return
				end
				local parser = vim.treesitter.get_parser(buf)
				if not parser then
					return
				end
				vim.keymap.set("n", incremental_selection.init_selection, function()
					local root = parser:parse()[1]:root()
					local cursor = vim.api.nvim_win_get_cursor(0)
					local node = root:named_descendant_for_range(cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2])
					if node then
						vim.api.nvim_win_set_cursor(0, { node:start() + 1, 0 })
						vim.cmd("normal! v")
						vim.api.nvim_win_set_cursor(0, { node:end_() + 1, 0 })
					end
				end, { buffer = buf, desc = "Init selection" })
			end,
		})

		-- Textobjects configuration (main branch API)
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
				include_surrounding_whitespace = true,
				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "<c-v>",
				},
			},
		})

		-- Textobject keymaps (main branch doesn't auto-create keymaps)
		local textobject_select = require("nvim-treesitter-textobjects.select")
		local textobject_keys = {
			["af"] = { query = "@function.outer", desc = "Select around function" },
			["if"] = { query = "@function.inner", desc = "Select inner function" },
			["ac"] = { query = "@class.outer", desc = "Select around class" },
			["ic"] = { query = "@class.inner", query_group = "textobjects", desc = "Select inner class" },
			["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				if is_bigfile(buf) then
					return
				end
				for lhs, spec in pairs(textobject_keys) do
					vim.keymap.set({ "x", "o" }, lhs, function()
						textobject_select.select_textobject(spec.query, spec.query_group)
					end, { buffer = buf, desc = spec.desc })
				end
			end,
		})
	end,
}
