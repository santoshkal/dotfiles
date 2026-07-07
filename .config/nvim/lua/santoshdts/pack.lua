local gh = function(repo)
	return "https://github.com/" .. repo
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.schedule(function()
				vim.cmd("TSUpdateSync")
			end)
		end
		if name == "mason.nvim" and kind == "install" then
			vim.schedule(function()
				require("mason").setup()
			end)
		end
	end,
})

vim.pack.add({
	gh("saghen/blink.lib"),
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
	gh("rafamadriz/friendly-snippets"),
	gh("akinsho/bufferline.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("catppuccin/nvim"),
	gh("folke/tokyonight.nvim"),
	gh("scottmckendry/cyberdream.nvim"),
	gh("numToStr/Comment.nvim"),
	gh("stevearc/conform.nvim"),
	gh("stevearc/dressing.nvim"),
	gh("ibhagwan/fzf-lua"),
	gh("lewis6991/gitsigns.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("folke/lazydev.nvim"),
	gh("kdheepak/lazygit.nvim"),
	gh("mfussenegger/nvim-lint"),
	gh("nvim-lualine/lualine.nvim"),
	gh("MeanderingProgrammer/render-markdown.nvim"),
	gh("echasnovski/mini.nvim"),
	gh("nvim-neo-tree/neo-tree.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("rcarriga/nvim-notify"),
	gh("folke/noice.nvim"),
	gh("obsidian-nvim/obsidian.nvim"),
	gh("folke/snacks.nvim"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-context"),
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
	gh("christoomey/vim-tmux-navigator"),
	gh("folke/todo-comments.nvim"),
	gh("akinsho/toggleterm.nvim"),
	gh("folke/trouble.nvim"),
	gh("folke/which-key.nvim"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
}, { load = true })

require("santoshdts.pack.blink")
require("santoshdts.pack.bufferline")
require("santoshdts.pack.catppuccin")
require("santoshdts.pack.tokyonight")
require("santoshdts.pack.comment")
require("santoshdts.pack.conform")
require("santoshdts.pack.dressing")
require("santoshdts.pack.fzf")
require("santoshdts.pack.gitsigns")
require("santoshdts.pack.harpoon")
require("santoshdts.pack.lazydev")
require("santoshdts.pack.lazygit")
require("santoshdts.pack.linter")
require("santoshdts.pack.lualine")
require("santoshdts.pack.markdown")
require("santoshdts.pack.mini")
require("santoshdts.pack.neotree")
require("santoshdts.pack.noice")
require("santoshdts.pack.obsidian")
require("santoshdts.pack.snacks")
require("santoshdts.pack.textobjects")
require("santoshdts.pack.tmux_navigator")
require("santoshdts.pack.todo_comments")
require("santoshdts.pack.toggleterm")
require("santoshdts.pack.treesitter")
require("santoshdts.pack.trouble")
require("santoshdts.pack.which_key")
require("santoshdts.pack.mason")
