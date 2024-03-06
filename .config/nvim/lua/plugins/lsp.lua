return {
   {
      "neovim/nvim-lspconfig",
      dependencies = {
         "williamboman/mason-lspconfig.nvim",
         "williamboman/mason.nvim",
         { "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp" } },
      },
      config = function()
         local lspconfig = require("lspconfig")
         local capabilities = require("cmp_nvim_lsp").default_capabilities()

         local on_attach = function()
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Show documentation" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Go to definition" })
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0, desc = "Go to type definition" })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0, desc = "Go to implementaion" })
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0, desc = "LSP Rename" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "LSP code actions" })
         end

         lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
               Lua = {
                  completion = { callSnippet = "Replace" },
                  diagnostics = { globals = { "vim" } },
                  workspace = { checkThirdParty = false },
               },
            },
         })

         lspconfig.gopls.setup({ capabilities = capabilities, on_attach = on_attach })
         lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
         lspconfig.rust_analyzer.setup({ capabilities = capabilities, on_attach = on_attach })
         lspconfig.terraformls.setup({ capabilities = capabilities, on_attach = on_attach })
      end,
   },
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      opts = {
         ensure_installed = {
            "gopls",
            "lua_ls",
            "pyright",
            "rust_analyzer",
            "terraformls",
         },
      },
   },
   {
      "williamboman/mason.nvim",
      cmd = "Mason",
      build = ":MasonUpdate",
      opts = {
         ensure_installed = {
            "black",
            "isort",
            "shfmt",
            "stylua",
         },
      },
   },
}
