-- ------------------------------------------------------------------------- }}}
-- \tt my beloved
-- vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>rightbelow term<CR><cmd>resize 15<CR>", { noremap = true })
--
-- -- Daily notes shortcuts I guess
-- vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>DailyNote<CR>", { noremap = true })

require("which-key").add({
	{ "<leader>tt", "<cmd>rightbelow term<CR><cmd>resize 15<CR>", desc = "Open Terminal below", mode = "n" },
	{ "<leader>l", group = "Developer Logs" },
	{ "<leader>ll", "<cmd>DailyNote<CR>", desc = "Create a Daily Note", mode = "n" },
	{ "<leader>lp", "<cmd>DailyNote day-1<CR>", desc = "Yesterdays Notes", mode = "n" },
})
-- ------------------------------------------------------------------------- }}}
