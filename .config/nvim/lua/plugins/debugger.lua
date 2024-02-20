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
               },
            },
         },
         {
            "leoluz/nvim-dap-go",
            opts = {},
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
         { "<leader>dT", function() require("dap-"..vim.bo.filetype).debug_test() end, desc = "Debug Test" },
      },
   },
}
