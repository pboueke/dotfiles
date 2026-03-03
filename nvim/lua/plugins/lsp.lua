return {
  -- Mason: installs LSP server binaries
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  -- Bridge: exposes the list of Mason-installed servers to Neovim
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls" },
    },
  },

  -- nvim-lspconfig: data source for server configs (cmd, filetypes, root_dir).
  -- We never call require('lspconfig').server.setup() — that API is deprecated
  -- in Neovim 0.11. Instead we use vim.lsp.config / vim.lsp.enable.
  {
    "neovim/nvim-lspconfig",
    lazy = false, -- must load at startup so servers are enabled before buffers open
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Apply enhanced completion capabilities to every server
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Enable every server that Mason has installed
      for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
        vim.lsp.enable(server)
      end

      -- Keymaps: registered once per buffer on attach, works for any server
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end
          map("gd",         vim.lsp.buf.definition,    "Go to Definition")
          map("gD",         vim.lsp.buf.declaration,   "Go to Declaration")
          map("gr",         vim.lsp.buf.references,    "References")
          map("gi",         vim.lsp.buf.implementation,"Go to Implementation")
          map("K",          vim.lsp.buf.hover,         "Hover Docs")
          map("<leader>rn", vim.lsp.buf.rename,        "Rename Symbol")
          map("<leader>ca", vim.lsp.buf.code_action,   "Code Action")
          map("<leader>d",  vim.diagnostic.open_float, "Line Diagnostics")
          map("[d",         vim.diagnostic.goto_prev,  "Prev Diagnostic")
          map("]d",         vim.diagnostic.goto_next,  "Next Diagnostic")
        end,
      })
    end,
  },
}
