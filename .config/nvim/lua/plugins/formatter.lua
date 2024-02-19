return {
   "stevearc/conform.nvim",
   event = { "BufWritePre" },
   cmd = { "ConformInfo" },
   keys = {
      {
         "<leader>ft",
         function()
            require("conform").format({ async = true, lsp_fallback = true })
         end,
         mode = "n",
         desc = "Format buffer",
      },
   },
   opts = {
      formatters_by_ft = {
         go = { "gofmt" },
         hcl = { "terragrunt_hclfmt" },
         lua = { "stylua" },
         python = { "isort", "black" },
         rust = { "rustfmt" },
         sh = { "shfmt" },
         terraform = { "terraform_fmt" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
   },
}
