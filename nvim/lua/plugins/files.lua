return {
  -- oil.nvim: edit the filesystem like a buffer
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "-",           "<cmd>Oil<cr>",                              desc = "Open parent directory" },
      { "<leader>vv",  "<cmd>Oil<cr>",                              desc = "Oil (current window)" },
      { "<leader>vV",  function() require("oil").open_float() end,  desc = "Oil (floating window)" },
    },
    opts = {},
  },
}
