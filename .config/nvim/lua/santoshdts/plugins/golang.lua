return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"leoluz/nvim-dap-go",
		},
		config = function()
			-- Function to organize imports
			local function organize_imports(client, bufnr)
				local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
				params.context = { only = { "source.organizeImports" } }

				local resp = client.request_sync("textDocument/codeAction", params, 3000, bufnr)
				for _, r in pairs(resp and resp.result or {}) do
					if r.edit then
						vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
					else
						vim.lsp.buf.execute_command(r.command)
					end
				end
			end

			-- Setup gopls with the necessary configuration
			local lspconfig = require("lspconfig")
			lspconfig.gopls.setup({
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							organize_imports(client, bufnr)
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = false,
							compositeLiteralFields = false,
							compositeLiteralTypes = false,
							constantValues = false,
							functionTypeParameters = false,
							parameterNames = false,
							rangeVariableTypes = false,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = false,
					},
				},
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			-- Setup go.nvim
			require("go").setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				luasnip = true,
				trouble = true,
			})

			-- Notify configuration
			vim.notify = require("notify")
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
}
