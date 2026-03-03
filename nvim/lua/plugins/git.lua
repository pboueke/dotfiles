return {
  -- vim-fugitive: Git porcelain inside Neovim
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gclog" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>",        desc = "Git status" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
      { "<leader>gb", "<cmd>Git blame<cr>",  desc = "Git blame" },
      { "<leader>gl", "<cmd>Gclog<cr>",      desc = "Git log" },
    },
  },

  -- gitsigns: hunk decorations, staging, and blame in the buffer
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]c", gs.next_hunk,    "Next hunk")
        map("n", "[c", gs.prev_hunk,    "Prev hunk")

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk,                                       "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk,                                       "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer,                                     "Stage buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk,                                  "Undo stage hunk")
        map("n", "<leader>hp", gs.preview_hunk,                                     "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end,        "Blame line")
        map("n", "<leader>hd", gs.diffthis,                                         "Diff this")

        -- Visual mode: stage/reset selected lines
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk (visual)")
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk (visual)")
      end,
    },
  },
}
