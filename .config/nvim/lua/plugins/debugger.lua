local function get_args(config)
   local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
   ---@cast args string[]

   config = vim.deepcopy(config)
   config.args = function()
      local new_args = vim.fn.input("Run with args: ", table.concat(args, " "))
      return vim.split(vim.fn.expand(new_args), " ")
   end

   return config
end

return {
   {
      "mfussenegger/nvim-dap",
      dependencies = {
         {
            "rcarriga/nvim-dap-ui",
            -- stylua: ignore
            keys = {
               { "<leader>du", function () require("dapui").toggle() end, desc = "DAP UI Toggle" },
               { "<leader>de", function () require("dapui").eval() end, desc = "DAP UI Eval", mode = { "n", "v" } },
            },
            config = function()
               local dap = require("dap")
               local dapui = require("dapui")

               dapui.setup()

               dap.listeners.after.event_initialized["dapui_config"] = function()
                  dapui.open()
               end
               dap.listeners.before.event_terminated["dapui_config"] = function()
                  dapui.close()
               end
               dap.listeners.before.event_exited["dapui_config"] = function()
                  dapui.close()
               end
            end,
         },
         {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "williamboman/mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
               automatic_installation = true,
               ensure_installed = {
                  "delve",
                  "python",
               },
            },
         },
      },
      -- stylua: ignore
      keys = {
         { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
         { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
         { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
         { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
         { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
         { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
         { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
         { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
         { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
         { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
         { "<leader>ds", function() require("dap").session() end, desc = "Session" },
         { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      },
   },
   {
      "leoluz/nvim-dap-go",
      dependencies = "mfussenegger/nvim-dap",
      ft = "go",
      config = function()
         require("dap-go").setup()

         -- stylua: ignore
         vim.keymap.set("n", "<leader>dT", function() require("dap-go").debug_test() end, { desc = "Debug Test" })
      end,
   },
   {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      config = function()
         local path = nil
         local ok, registry = pcall(require, "mason-registry")

         if ok and registry.is_installed("debugpy") then
            local pkg = registry.get_package("debugpy")
            local sep = package.config:sub(1, 1)
            path = table.concat({ pkg:get_install_path(), "venv", "bin", "python" }, sep)
         end

         require("dap-python").setup(path)

         -- stylua: ignore start
         vim.keymap.set("n", "<leader>dT", function() require("dap-python").test_method() end, { desc = "Debug Test Method" })
         vim.keymap.set("n", "<leader>dA", function() require("dap-python").test_class() end, { desc = "Debug Test Class" })
         -- stylua: ignore end
      end,
   },
}
