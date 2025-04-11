local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "santoshdts.plugins" }, { import = "santoshdts.plugins.lsp" } }, {
	change_detection = {
		notify = false,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	install = {
		missing = true,
		colorscheme = { "cyberdream" },
	},
	checker = { enabled = true },
	dev = {
		path = "~/git",
		fallback = true,
	},
	ui = {
		title = " lazy.nvim 💤",
		border = "rounded",
		pills = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"zipPlugin",
				"netrwPlugin",
				"tutor",
			},
		},
	},
})
