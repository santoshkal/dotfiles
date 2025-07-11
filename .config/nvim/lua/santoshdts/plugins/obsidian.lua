return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- bring in cmp & its snippet deps only for Obsidian
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  opts = {
    workspaces = {
      {
        name = "DevOps",
        path = "~/Dropbox/devops",
        overrides = { notes_subdir = "00-Inbox" },
      },
    },
    completion = {
      nvim_cmp  = true, -- switch on the built-in CMP source
      min_chars = 2,
    },
    -- … your other obsidian.nvim settings …
  },
  config = function(_, opts)
    -- 1) setup obsidian itself
    require("obsidian").setup(opts)

    -- 2) configure nvim-cmp _only_ for markdown (i.e. your vault)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup.filetype("markdown", {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-n>"]     = cmp.mapping.select_next_item(),
        ["<C-p>"]     = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"]      = cmp.mapping.confirm({ select = true }),
        ["<Tab>"]     = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"]   = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmp.config.sources({
        { name = "obsidian" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      completion = {
        keyword_length = 2,
      },
    })
  end,
}
