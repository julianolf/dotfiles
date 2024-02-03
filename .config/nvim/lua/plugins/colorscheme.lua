return {
   {
      "rose-pine/neovim",
      name = "rose-pine",
      priority = 1000,
      opts = { dim_inactive_windows = true },
      config = function(_, opts)
         require("rose-pine").setup(opts)
         vim.cmd([[colorscheme rose-pine]])
      end
   }
}
