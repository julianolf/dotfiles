return {
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      opts = {
         sync_install = false,
         auto_install = true,
         highlight = { enable = true },
         indent = { enable = true },
         ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "csv",
            "diff",
            "dockerfile",
            "go",
            "gomod",
            "gosum",
            "html",
            "javascript",
            "jq",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rst",
            "ruby",
            "rust",
            "sql",
            "terraform",
            "toml",
            "vim",
            "vimdoc",
            "yaml",
         }
      },
      init = function (plugin)
         require("lazy.core.loader").add_to_rtp(plugin)
         require("nvim-treesitter.query_predicates")
      end,
      config = function (_, opts)
         if type(opts.ensure_installed) == "table" then
            local added = {}
            opts.ensure_installed = vim.tbl_filter(
               function (lang)
                  if added[lang] then
                     return false
                  end
                  added[lang] = true
                  return true
               end,
               opts.ensure_installed
            )
         end
         require("nvim-treesitter.configs").setup(opts)
      end,
   }
}
