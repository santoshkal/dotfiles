return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = { enable = true, mode = "topline", line_numbers = true },
    },
  },
  config = function()
    -- Workaround for Neovim 0.12 bug: injected language parsers can return
    -- invalidated TSNode userdata (freed tree, nil metatable), causing
    -- "attempt to call method 'range' (a nil value)" in get_range/get_node_text.
    do
      local ok, ts = pcall(require, "vim.treesitter")
      if ok and ts.get_range then
        local orig = ts.get_range
        ts.get_range = function(node, source, metadata)
          if node == nil then
            return { 0, 0, 0, 0 }
          end
          local ok_range, result = pcall(orig, node, source, metadata)
          if ok_range then
            return result
          end
          return { 0, 0, 0, 0 }
        end
      end
    end

    -- Set up nvim-treesitter commands and auto-install
    require("nvim-treesitter").setup()

    -- Install parsers
    require("nvim-treesitter.install").install({
      "csv",
      "dockerfile",
      "gitignore",
      "cue",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "javascript",
      "json",
      "lua",
      "markdown",
      "proto",
      "python",
      "rego",
      "sql",
      "yaml",
    })
  end,
}
