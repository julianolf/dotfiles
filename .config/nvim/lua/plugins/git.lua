return {
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
            map("n", "]c", next_hunk, { expr = true , desc = "Git go to next hunk" })
            map("n", "[c", prev_hunk, { expr = true , desc = "Git go to previous hunk" })

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
}
