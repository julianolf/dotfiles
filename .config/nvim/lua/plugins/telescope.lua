return {
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
      },
      config = function()
         local builtin = require("telescope.builtin")

         vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
         vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope git files" })
         vim.keymap.set("n", "<leader>fG", builtin.live_grep, { desc = "Telescope live grep" })
         vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
         vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
         vim.keymap.set("n", "<leader>fi", builtin.diagnostics, { desc = "Telescope diagnostics" })
      end,
   },
}
