return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see above for full list of optional dependencies ☝️
  },
  opts = {
    workspaces = {
      {
        name = "DevOps",
        path = "~/Dropbox/devops/",
        overrides = {
          notes_subdir = "00-Inbox",
        },
      },
    },
    notes_subdir = "00-Inbox",
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = false,
      -- Enables completion using blink.cmp
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
      -- Set to false to disable new note creation in the picker
      create_new = true,
    },
    new_notes_location = "notes_subdir",

    -- TODO: Fix the syntax for inseting date in 'YYYYMMMMDDHHSS' format to ID.
    -- see below for full list of options 👇
    -- templates = {
    --   folder = "templates",
    --   -- -- A map for custom variables, the key should be the variable and the value a function.
    --   -- -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
    --   -- -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
    --   substitutions = {
    --     -- This will insert the current date/time as YYYYMMDDHHMM
    --     my_date = function()
    --       return os.date("%Y%m%d%H%M")
    --     end,
    --   },
    -- },
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
      name = "fzf-lua",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
    ui = {
      enabled = true,
    },
  },
}
