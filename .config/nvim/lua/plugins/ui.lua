return {
   {
      "lukas-reineke/indent-blankline.nvim",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
         indent = {
            char = "│",
            tab_char = "│",
         },
         scope = { enabled = false },
         exclude = {
            filetypes = {
               "help",
               "alpha",
               "dashboard",
               "lazy",
               "mason",
               "notify",
            },
         },
      },
      main = "ibl",
   },
   {
      "echasnovski/mini.indentscope",
      version = false,
      event = { "BufReadPost", "BufNewFile" },
      opts = {
         symbol = "│",
         options = { try_as_border = true },
      },
      init = function()
         vim.api.nvim_create_autocmd("FileType", {
            pattern = {
               "help",
               "alpha",
               "dashboard",
               "lazy",
               "mason",
               "notify",
            },
            callback = function()
               vim.b.miniindentscope_disable = true
            end,
         })
      end,
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
         options = { section_separators = "", component_separators = "" },
      },
   },
}
