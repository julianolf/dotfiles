return {
   {
      "neovim/nvim-lspconfig",
      opts = {
         servers = { -- fixme: show feedbacks immediately
            bashls = {},
            dockerls = {},
            gopls = {},
            pyright = {},
            rust_analyzer = {},
            terraformls = {}, -- fixme: improve auto-filetype
            sqlls = {},
            yamlls = {}, -- todo: lots of configs to properly work
         },
      },
   },
}
