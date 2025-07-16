return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({
        file_types = {
          "markdown",
          "vimwiki",
        },
        preset = "obsidian",
        completions = {
          blink = {
            enabled = true,
          },
        },
        heading = {
          enabled = true,
          sign = true,
          position = "overlay",
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          signs = { "󰫎 " },
          width = "full",
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
          border = false,
          border_prefix = false,
          above = "▄",
          below = "▀",
        },
      })
    end,
  },
}
