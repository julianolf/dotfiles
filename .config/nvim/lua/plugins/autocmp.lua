return {
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
      },
      event = "InsertEnter",
      opts = function()
         local cmp = require("cmp")
         local defaults = require("cmp.config.default")()

         return {
            completion = { completeopt = "menu,menuone,noinsert" },
            mapping = cmp.mapping.preset.insert({
               ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
               ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
               ["<C-b>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<C-Space>"] = cmp.mapping.complete(),
               ["<C-e>"] = cmp.mapping.abort(),
               ["<CR>"] = cmp.mapping.confirm({ select = true }),
               ["<S-CR>"] = cmp.mapping.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
               }),
               ["<C-CR>"] = function(fallback)
                  cmp.abort()
                  fallback()
               end,
            }),
            sources = cmp.config.sources({
               { name = "nvim_lsp" },
               { name = "path" },
            }, {
               { name = "buffer" },
            }),
            sorting = defaults.sorting,
         }
      end,
      config = function(_, opts)
         for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
         end

         require("cmp").setup(opts)
      end,
   },
   {
      "L3MON4D3/LuaSnip",
      dependencies = {
         "saadparwaiz1/cmp_luasnip",
         {
            "hrsh7th/nvim-cmp",
            opts = function(_, opts)
               opts.snippet = {
                  expand = function(args)
                     require("luasnip").lsp_expand(args.body)
                  end,
               }

               table.insert(opts.sources, { name = "luasnip" })
            end,
         },
      },
      opts = {
         history = true,
         delete_check_events = "TextChanged",
      },
      keys = {
         {
            "<tab>",
            function()
               return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true,
            silent = true,
            mode = "i",
         },
         {
            "<tab>",
            function()
               require("luasnip").jump(1)
            end,
            mode = "s",
         },
         {
            "<s-tab>",
            function()
               require("luasnip").jump(-1)
            end,
            mode = { "i", "s" },
         },
      },
   },
   {
      "github/copilot.vim",
   },
}
