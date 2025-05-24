return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		{ "j-hui/fidget.nvim", opts = {} },
	},
	-- Config from nvim-kickstart
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Setup keybindings when LSP attaches to buffer
		local on_attach = function(client, bufnr)
			local function buf_set_keymap(...)
				vim.api.nvim_buf_set_keymap(bufnr, ...)
			end
			local function buf_set_option(...)
				vim.api.nvim_buf_set_option(bufnr, ...)
			end

			buf_set_option("tagfunc", "v:lua.vim.lsp.tagfunc")
			local opts = { noremap = true, silent = true }

			buf_set_keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
			buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
			buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
			buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
			buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
			buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
			buf_set_keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
			client.server_capabilities.document_formatting = true
		end
		-- use to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Ensure the LSP servers are installed
		-- mason_lspconfig.setup({
		-- 	ensure_installed = {
		-- 		"lua_ls",
		-- 		"dockerls",
		-- 		"docker_compose_language_service",
		-- 		"jsonls",
		-- 		"jqls",
		-- 		"gopls",
		-- 		-- "pyright"
		-- 		"regols",
		-- 		"rust_analyzer",
		-- 		"terraformls",
		-- 		"yamlls",
		-- 	},
		-- })
		--
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completions = {
						callSnippet = "Replace",
					},
				},
			},
		})

		lspconfig.jqls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "jq-lsp" },
			filetypes = { "jq" },
			root_markers = { ".git" },
		})

		lspconfig.pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_markers = {
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"Pipfile",
				"pyrightconfig.json",
				".git",
			},
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
					},
				},
			},
		})
		-- Setup gopls server
		lspconfig.gopls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})
	end,
}
