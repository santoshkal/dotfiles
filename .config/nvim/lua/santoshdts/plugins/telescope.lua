return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"folke/trouble.nvim", -- ensure trouble.nvim is included as a dependency
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.providers.telescope")
		local builtin = require("telescope.builtin")
		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = require("trouble.sources.telescope").open, -- updated to use the new function
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>fn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ind [N]eovim files" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]uzzy [F]ind files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "[F]uzzy find [R]ecent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [S]tring in cwd" })
		keymap.set(
			"n",
			"<leader>fc",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "[F]ind string under [C]ursor in cwd" }
		)
		--keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind strings using [G]rep" })
		keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "[F]ind [T]elescope function, variables names" })
		keymap.set("n", "<leader>fp", builtin.git_files, { desc = "[F]ind Git [P]roject files" })
		keymap.set("n", "<leader>fb", builtin.builtin, { desc = "[F]ind Telescope [B]uiltins" })
		keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		keymap.set("n", "<leader>fo", builtin.buffers, { desc = "[F]ind [O]pen buffers" })

		-- Enable line numbers in the telescope preview window
		vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })
	end,
}
