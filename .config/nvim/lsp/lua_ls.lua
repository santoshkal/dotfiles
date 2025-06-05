return {
	cmd = {
		"lua-language-server",
	},
	filetypes = {
		"lua",
	},
	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				-- path = vim.split(package.path, ";"),
			},
			completion = {
				callSnippet = "replace",
			},
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
					-- [vim.fn.stdpath("config") .. "/lua"] = true,
					"${3rd}/luv/library",
					unpack(vim.api.nvim_get_runtime_file("", true)),
				},
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},

	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
