return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },

	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = "cargo build --release",
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',
	opts = {
		fuzzy = { implementation = "prefer_rust_with_warning" },
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "label", gap = 10 },
						{ "kind_icon", gap = 1 },
						{ "kind" },
						{ "label_description" },
					},

					gap = 1,
					treesitter = { "lsp" },
				},
			},
			list = {
				selection = { preselect = false, auto_insert = true },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
				},
			},
			ghost_text = {
				enabled = true,
			},
		},
		signature = { enabled = true, window = { border = "single" } },
		-- sources = {
		--   providers = {
		--     ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
		--     codecompanion = {
		--       name = "CodeCompanion",
		--       module = "codecompanion.providers.completion.blink",
		--     },
		--   },
		--   default = { "lsp", "path", "snippets", "buffer" },
		-- },
		sources = {
			default = { "lsp", "snippets", "path", "buffer" },
			providers = {
				snippets = {
					min_keyword_length = 1,
					score_offset = 4,
				},
				lsp = {
					min_keyword_length = 0,
					score_offset = 3,
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					transform_items = function(_, items)
						return vim.tbl_filter(function(item)
							return item.kind ~= require("blink.cmp.types").CompletionItemKind.Keyword
						end, items)
					end,
					fallbacks = {},
				},
				path = {
					min_keyword_length = 0,
					score_offset = 2,
				},
				buffer = {
					min_keyword_length = 1,
					score_offset = 1,
				},
			},
		},
		cmdline = {
			sources = {},
			keymap = { preset = "enter" },
			completion = { menu = { auto_show = true } },
		},
		-- cmdline = {
		-- 	enabled = true,
		-- 	---@diagnostic disable-next-line: assign-type-mismatch
		-- 	sources = function()
		-- 		local type = vim.fn.getcmdtype()
		-- 		-- Search forward and backward
		-- 		if type == "/" or type == "?" then
		-- 			return { "buffer" }
		-- 		end
		-- 		-- Commands
		-- 		if type == ":" or type == "@" then
		-- 			return { "cmdline" }
		-- 		end
		-- 		return {}
		-- 	end,
		-- 	keymap = {
		-- 		["<Down>"] = { "select_next", "fallback" },
		-- 		["<Up>"] = { "select_prev", "fallback" },
		-- 	},
		-- 	completion = {
		-- 		menu = {
		-- 			auto_show = true,
		-- 			draw = {
		-- 				columns = { { "kind_icon", "label", "label_description", gap = 1 } },
		-- 			},
		-- 		},
		-- 	},
		-- },
		appearance = {
			kind_icons = {
				Text = "󰉿",
				Method = "",
				Function = "󰊕",
				Constructor = "󰒓",
				Field = "",
				Variable = "󰆦",
				Property = "󰖷",
				Class = "",
				Interface = "",
				Struct = "󱡠",
				Module = "󰅩",
				Unit = "󰪚",
				Value = "",
				Enum = "",
				EnumMember = "",
				Keyword = "",
				Constant = "󰏿",
				Snippet = "",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
				Error = "󰏭",
				Warning = "",
				Information = "󰋼",
				Hint = "",
			},
		},
		keymap = {
			preset = "enter",
			-- ["<CR>"] = { "select_and_accept" },
			-- ["<Tab>"] = { "snippet_forward", "fallback" },
			-- ["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
	},
	opts_extend = { "sources.default" },
}
