return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/marksman", "server" },
  filetypes = { "markdown" },
  root_markers = { ".git", ".md" },
  single_file_support = true,
}
