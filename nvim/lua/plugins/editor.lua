return {
  -- Comment.nvim — replaces tpope/vim-commentary with a Lua-native implementation
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n",           desc = "Toggle line comment" },
      { "gc",  mode = { "n", "v" },  desc = "Toggle comment" },
      { "gbc", mode = "n",           desc = "Toggle block comment" },
    },
    opts = {},
  },

  -- nvim-surround — replaces tpope/vim-surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Grapple — file tagging / quick navigation (harpoon-style)
  {
    "cbochs/grapple.nvim",
    keys = {
      { "<leader>a",  function() require("grapple").toggle() end,              desc = "Grapple: tag/untag file" },
      { "<leader>e",  function() require("grapple").toggle_tags() end,         desc = "Grapple: open tags" },
      { "<leader>1",  function() require("grapple").select({ index = 1 }) end, desc = "Grapple: jump to 1" },
      { "<leader>2",  function() require("grapple").select({ index = 2 }) end, desc = "Grapple: jump to 2" },
      { "<leader>3",  function() require("grapple").select({ index = 3 }) end, desc = "Grapple: jump to 3" },
      { "<leader>4",  function() require("grapple").select({ index = 4 }) end, desc = "Grapple: jump to 4" },
    },
    opts = {},
  },
}
