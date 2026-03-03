return {
  -- vim-polyglot: syntax and indent support for 600+ languages
  -- Complements treesitter for languages not yet covered by it.
  -- Must load before buffers are opened (lazy = false).
  {
    "sheerun/vim-polyglot",
    lazy = false,
    init = function()
      -- Prevent polyglot from overriding treesitter-managed languages.
      -- Add language names here if you notice conflicts.
      vim.g.polyglot_disabled = { "sensible" }
    end,
  },
}
