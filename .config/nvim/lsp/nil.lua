
return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/nil", "start" },
	settings = {
    "nil" = {
      formatting = {
        command = { "nixfmt" },
      },
    },
	},
	filetypes = {"nix"},
	root_markers = { "flake.nix", ".git"},
}
