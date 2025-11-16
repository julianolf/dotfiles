vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.showmode = false

vim.keymap.set("n", "<leader>fd", vim.cmd.Ex, { desc = "Explore directory of current file" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>jj", "<cmd>bN<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>kk", "<cmd>bp<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left windown" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right windown" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower windown" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper windown" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float, { desc = "Open diagnostic quickfix list" })

vim.api.nvim_create_autocmd("TextYankPost", {
   desc = "Highlight when yanking text",
   group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
   callback = function()
      vim.highlight.on_yank()
   end,
})

-- Install Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
   })
end

vim.opt.rtp:prepend(lazypath)

-- Install and configure plugins with Lazy
local lazyplugins = {
   -- treesitter (a.k.a. ast magic)
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      opts = {
         auto_install = true,
         highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "ruby" },
         },
         indent = {
            enable = true,
            disable = { "ruby" },
         },
         ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "diff",
            "dockerfile",
            "git_config",
            "git_rebase",
            "gitcommit",
            "gitignore",
            "go",
            "gomod",
            "gosum",
            "html",
            "javascript",
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
            "zig",
         },
      },
      config = function(_, opts)
         require("nvim-treesitter.configs").setup(opts)
      end,
   },

   -- fuzzy finder
   {
      "nvim-telescope/telescope.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      config = function()
         local builtin = require("telescope.builtin")

         local function map(kmap, cmd, desc)
            vim.keymap.set("n", kmap, cmd, { desc = "Telescope: " .. desc })
         end

         map("<leader>ff", builtin.find_files, "Find files")
         map("<leader>fg", builtin.git_files, "Git files")
         map("<leader>fG", builtin.live_grep, "Live grep")
         map("<leader>fb", builtin.buffers, "Buffers")
         map("<leader>fh", builtin.help_tags, "Help tags")
         map("<leader>fi", builtin.diagnostics, "Diagnostics")
         map("<leader>fk", builtin.keymaps, "Keymaps")
      end,
   },

   -- git integration
   {
      "lewis6991/gitsigns.nvim",
      dependencies = "tpope/vim-fugitive",
      opts = {
         on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, keymap, command, options)
               options = options or {}
               options.buffer = bufnr
               vim.keymap.set(mode, keymap, command, options)
            end

            local function next_hunk()
               if vim.wo.diff then
                  return "]c"
               end

               vim.schedule(function()
                  gs.next_hunk()
               end)

               return "<Ignore>"
            end

            local function prev_hunk()
               if vim.wo.diff then
                  return "[c"
               end

               vim.schedule(function()
                  gs.prev_hunk()
               end)

               return "<Ignore>"
            end

            -- stylua: ignore start
            map("n", "]c", next_hunk, { expr = true, desc = "Git go to next hunk" })
            map("n", "[c", prev_hunk, { expr = true, desc = "Git go to previous hunk" })
            map("n", "<leader>hs", gs.stage_hunk, { desc = "Git stage hunk" })
            map("n", "<leader>hr", gs.reset_hunk, { desc = "Git reset hunk" })
            map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git stage selected hunk" })
            map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git reset selected hunk" })
            map("n", "<leader>hS", gs.stage_buffer, { desc = "Git stage buffer" })
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git undo stage hunk" })
            map("n", "<leader>hR", gs.reset_buffer, { desc = "Git reset buffer" })
            map("n", "<leader>hp", gs.preview_hunk, { desc = "Git preview hunk" })
            map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Git blame line" })
            map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Git toggle blame line" })
            map("n", "<leader>hd", gs.diffthis, { desc = "Git diff base" })
            map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Git diff last commit" })
            map("n", "<leader>td", gs.toggle_deleted, { desc = "Git toggle show deleted" })
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
            -- stylua: ignore stop
         end,
      },
   },

   -- auto completion
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-nvim-lsp",
         "onsails/lspkind.nvim",
         {
            "saadparwaiz1/cmp_luasnip",
            dependencies = {
               "L3MON4D3/LuaSnip",
               build = "make install_jsregexp",
            },
         },
      },
      event = "InsertEnter",
      config = function()
         local luasnip = require("luasnip")
         luasnip.config.setup({})

         local defaults = require("cmp.config.default")()
         local lspkind = require("lspkind")
         local cmp = require("cmp")

         cmp.setup({
            snippet = {
               expand = function(args)
                  luasnip.lsp_expand(args.body)
               end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },
            mapping = cmp.mapping.preset.insert({
               ["<C-n>"] = cmp.mapping.select_next_item(),
               ["<C-p>"] = cmp.mapping.select_prev_item(),
               ["<C-b>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<C-y>"] = cmp.mapping.confirm({ select = true }),
               ["<C-Space>"] = cmp.mapping.complete(),
               ["<C-e>"] = cmp.mapping.abort(),
            }),
            sources = {
               { name = "nvim_lsp" },
               { name = "luasnip" },
               { name = "path" },
               { name = "buffer" },
            },
            sorting = defaults.sorting,
            formatting = {
               format = lspkind.cmp_format({
                  mode = "symbol",
                  maxwidth = 50,
                  ellipsis = "…",
                  show_labelDetails = true,
                  symbol_map = {},
                  before = function(_, vim_item)
                     return vim_item
                  end,
               }),
            },
         })
      end,
   },

   -- lsp
   {
      "neovim/nvim-lspconfig",
      dependencies = {
         "mason-org/mason.nvim",
         "mason-org/mason-lspconfig.nvim",
         { "j-hui/fidget.nvim", opts = {} },
         { "folke/neodev.nvim", opts = {} },
      },
      config = function()
         vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("x-lsp-attach", { clear = true }),
            callback = function(event)
               local function map(keys, func, desc)
                  vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
               end

               map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
               map("gr", require("telescope.builtin").lsp_references, "Goto References")
               map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
               map("<leader>gt", require("telescope.builtin").lsp_type_definitions, "Type Definition")
               map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
               map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
               map("<leader>rn", vim.lsp.buf.rename, "Rename")
               map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
               map("K", vim.lsp.buf.hover, "Hover Documentation")
               map("gD", vim.lsp.buf.declaration, "Goto Declaration")

               local client = vim.lsp.get_client_by_id(event.data.client_id)

               if client and client.server_capabilities.documentHighlightProvider then
                  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                     buffer = event.buf,
                     callback = vim.lsp.buf.document_highlight,
                  })

                  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                     buffer = event.buf,
                     callback = vim.lsp.buf.clear_references,
                  })
               end
            end,
         })

         local capabilities = vim.lsp.protocol.make_client_capabilities()
         -- requires cmp-nvim-lsp
         capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

         local servers = {
            bashls = {},
            clangd = {},
            gopls = {},
            pyright = {},
            rust_analyzer = {},
            taplo = {},
            terraformls = {},
            zls = {},
            lua_ls = {
               settings = {
                  Lua = {
                     completion = { callSnippet = "Replace" },
                     diagnostics = { globals = { "vim" } },
                  },
               },
            },
         }

         require("mason").setup()
         require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers or {}),
            handlers = {
               function(server_name)
                  local server = servers[server_name] or {}
                  server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                  require("lspconfig")[server_name].setup(server)
               end,
            },
         })
      end,
   },

   -- debuggers
   {
      "mfussenegger/nvim-dap",
      dependencies = {
         "mason-org/mason.nvim",
         "jay-babu/mason-nvim-dap.nvim",
         {
            "rcarriga/nvim-dap-ui",
            dependencies = "nvim-neotest/nvim-nio",
            config = function()
               local dap = require("dap")
               local dapui = require("dapui")

               dapui.setup()

               dap.listeners.after.event_initialized["dapui_config"] = dapui.open
               dap.listeners.before.event_terminated["dapui_config"] = dapui.close
               dap.listeners.before.event_exited["dapui_config"] = dapui.close

               vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: UI Toggle" })
               vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "DAP: UI Eval" })
            end,
         },
      },
      config = function()
         local function map(kmap, cmd, desc)
            vim.keymap.set("n", kmap, cmd, { desc = "DAP: " .. desc })
         end

         local function get_args(config)
            local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
            --- @cast args string[]

            config = vim.deepcopy(config)
            config.args = function()
               local new_args = vim.fn.input("Run with args: ", table.concat(args, " "))
               return vim.split(vim.fn.expand(new_args), " ")
            end

            return config
         end

         local dap = require("dap")

         -- stylua: ignore start
         map("<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "Breakpoint condition")
         map("<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
         map("<leader>dC", dap.run_to_cursor, "Run to cursor")
         map("<leader>dc", dap.continue, "Continue")
         map("<leader>da", function() dap.continue({ before = get_args }) end, "Continue with args")
         map("<leader>di", dap.step_into, "Step into")
         map("<leader>do", dap.step_out, "Step out")
         map("<leader>dO", dap.step_over, "Step over")
         map("<leader>dp", dap.pause, "Pause")
         map("<leader>dr", dap.repl.toggle, "Toggle REPL")
         map("<leader>ds", dap.session, "Session")
         map("<leader>dt", dap.terminate, "Terminate")
         -- stylua: ignore stop

         local debuggers = { "codelldb", "python", "delve" }

         require("mason").setup()
         require("mason-nvim-dap").setup({ ensure_installed = debuggers })
      end,
   },
   {
      "julianolf/nvim-dap-lldb",
      dependencies = "mfussenegger/nvim-dap",
      ft = { "c", "cpp", "rust" },
      config = function()
         local dap_lldb = require("dap-lldb")

         dap_lldb.setup()

         vim.keymap.set("n", "<leader>dT", dap_lldb.debug_test, { desc = "DAP: Debug Test" })
      end,
   },
   {
      "mfussenegger/nvim-dap-python",
      dependencies = "mfussenegger/nvim-dap",
      ft = "python",
      config = function()
         local dap_python = require("dap-python")
         dap_python.setup("debugpy-adapter")

         local uv = vim.uv or vim.loop

         if uv.fs_stat(".vscode/launch.json") then
            require("dap.ext.vscode").load_launchjs(nil, { debugpy = { "python" } })
         end

         vim.keymap.set("n", "<leader>dT", dap_python.test_method, { desc = "DAP: Debug Test Method" })
         vim.keymap.set("n", "<leader>dA", dap_python.test_class, { desc = "DAP: Debug Test Class" })
      end,
   },
   {
      "leoluz/nvim-dap-go",
      dependencies = "mfussenegger/nvim-dap",
      ft = "go",
      config = function()
         local dap_go = require("dap-go")

         dap_go.setup()

         vim.keymap.set("n", "<leader>dT", dap_go.debug_test, { desc = "DAP: Debug Test" })
      end,
   },

   -- commenting made easy
   { "numToStr/Comment.nvim", opts = {} },

   -- code formatting
   {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = "ConformInfo",
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
            python = { "ruff_format", "ruff_fix" },
            rust = { "rustfmt" },
            sh = { "shfmt" },
            toml = { "taplo" },
            terraform = { "terraform_fmt" },
            zig = { "zigfmt" },
         },
         format_on_save = { timeout_ms = 500, lsp_fallback = true },
         formatters = {},
      },
   },

   -- colorscheme
   {
      "rose-pine/neovim",
      name = "rose-pine",
      priority = 1000,
      opts = { dim_inactive_windows = true },
      config = function(_, opts)
         require("rose-pine").setup(opts)
         vim.cmd([[colorscheme rose-pine]])
      end,
   },

   -- ui (fancy status bar & current scope visualization)
   {
      "nvim-lualine/lualine.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {
         options = {
            section_separators = "",
            component_separators = "",
         },
      },
   },
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
      event = { "BufReadPost", "BufNewFile" },
      version = false,
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
}

-- Lazy configuration
local lazyspecs = {
   dev = { path = "~/github/julianolf" },
   performance = {
      rtp = {
         disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
         },
      },
   },
}

require("lazy").setup(lazyplugins, lazyspecs)
