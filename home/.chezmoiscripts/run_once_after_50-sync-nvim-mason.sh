
#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

sync_pack_plugins() {
	nvim --headless \
		-c 'lua vim.pack.update(nil, { target = "lockfile", force = true })' \
		-c 'quitall'

	echo "Syncing Neovim plugins..."
}

sync_mason_tools() {
	nvim --headless \
		-c 'lua require("mason-tool-installer").check_install(true, true)' \
		-c 'lua require("mason-tool-installer").clean()' \
		-c 'quitall'

	echo "Syncing Mason tools..."
}

main() {
	if ! command -v nvim >/dev/null 2>&1; then
		echo "Neovim is not installed. Skipping syncing Neovim plugins."
		return 0
	fi

	sync_pack_plugins
	printf '\n'
	sync_mason_tools
}

main "$@"
