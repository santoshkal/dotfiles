require('catppuccin').setup({
  transparent_background = true,
  custom_highlights = function(colors)
    local u = require('catppuccin.utils.colors')
    return {
      CursorLine = {
        bg = u.vary_color(
          { latte = u.lighten(colors.mantle, 0.40, colors.base) },
          u.darken(colors.surface0, 0.30, colors.base)
        ),
      },
    }
  end,
  flavour = 'mocha',
  styles = { comments = { 'italic' } },
  dim_inactive = {
    enabled = false,
    shade = 'dark',
    percentage = 0.10,
  },
  integrations = {
    fzf = true,
    cmp = true,
    dap = { enabled = true, enable_ui = true },
    gitsigns = true,
    indent_blankline = { enabled = true, scope_color = 'lavender', colored_indent_levels = false },
    lsp_trouble = true,
    markdown = true,
    mason = true,
    blink_cmp = { style = 'bordered' },
    native_lsp = {
      enabled = true,
      virtual_text = { errors = { 'italic' }, hints = { 'italic' }, warnings = { 'italic' }, information = { 'italic' } },
      underlines = { errors = { 'undercurl' }, hints = { 'undercurl' }, warnings = { 'undercurl' }, information = { 'undercurl' } },
      inlay_hints = { background = true },
    },
    neotree = true,
    noice = true,
    notify = true,
    semantic_tokens = true,
    treesitter = true,
    ts_rainbow2 = true,
    which_key = true,
  },
})

vim.cmd.colorscheme('catppuccin-mocha')
