return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/marksman", "server" },
  filetypes = { "markdown" },
  root_markers = { ".md", ".git" },
}
