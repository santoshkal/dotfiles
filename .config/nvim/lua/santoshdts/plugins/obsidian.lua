return {
  "obsidian-nvim/obsidian.nvim",
  -- events = {
  --   "BufReadPre " .. vim.fn.expand("~") .. "/Dropbox/devops/**/*.md",
  -- },
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "Saghen/blink.cmp",
  },
  keys = {
    { "<leader>oo",       "<cmd>Obsidian open<CR>",               desc = "Open on App" },
    { "<leader>os",       "<cmd>Obsidian search<CR>",             desc = "Obsidian Search" },
    { "<leader>on",       "<cmd>Obsidian new<CR>",                desc = "New Note" },
    { "<leader>oN",       "<cmd>Obsidian new_from_template<CR>",  desc = "New Note (Template)" },
    { "<leader>o<space>", "<cmd>Obsidian quick_switch<CR>",       desc = "Find Files" },
    { "<leader>ob",       "<cmd>Obsidian backlinks<CR>",          desc = "Backlinks" },
    { "<leader>ot",       "<cmd>Obsidian tags<CR>",               desc = "Tags" },
    { "<leader>oT",       "<cmd>Obsidian template<CR>",           desc = "Template" },
    { "<leader>oL",       "<cmd>Obsidian link<CR>",               mode = "v",                  desc = "Link" },
    { "<leader>oi",       "<cmd>Obsidian links<CR>",              desc = "Links" },
    { "<leader>oe",       "<cmd>Obsidian link_new<CR>",           mode = "v",                  desc = "Extract and Link New Note" },
    { "<leader>ow",       "<cmd>Obsidian workspace<CR>",          desc = "Workspace" },
    { "<leader>or",       "<cmd>Obsidian rename<CR>",             desc = "Rename" },
    { "<CR>",             "<cmd>Obsidian follow_link vsplit<CR>", desc = "Follow link" },

    -- { prefix .. "i", "<cmd>Obsidian paste_img<CR>", desc = "Paste Image" },
    -- { prefix .. "d", "<cmd>Obsidian dailies<CR>", desc = "Daily Notes" },
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
    ["gd"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
  },
  opts = {
    ui = {
      enabled = false,
    },
    workspaces = {
      {
        name = "DevOps",
        path = "~/Dropbox/devops",
        overrides = { notes_subdir = "00-Inbox" },
      },
    },
    notes_subdir = "00-Inbox",
    disable_frontmatter = true,

    completion = {
      nvim_cmp = false, -- switch on the built-in CMP source
      blink    = true,
    },
    note_id_func = function(title)
      if title ~= nil then
        return title
      else
        return os.date("%Y%m%d%H%M")
      end
    end,
    legacy_commands = false,
    templates = {
      folder = "templates",
      date_format = "%Y%m%d%H%M",
    },
    picker = {
      name = "fzf-lua",
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
    },
    -- … your other obsidian.nvim settings …
  },

}
