return {
  -- vifm.vim: open the vifm file manager inside Neovim splits
  -- Requires vifm to be installed on the system: `sudo apt install vifm` / `brew install vifm`
  {
    "vifm/vifm.vim",
    cmd = { "EditVifm", "SplitVifm", "VsplitVifm", "TabVifm", "DiffVifm" },
    keys = {
      { "<leader>vv", "<cmd>EditVifm<cr>",   desc = "Vifm (current window)" },
      { "<leader>vs", "<cmd>SplitVifm<cr>",  desc = "Vifm (horizontal split)" },
      { "<leader>vV", "<cmd>VsplitVifm<cr>", desc = "Vifm (vertical split)" },
    },
  },
}
