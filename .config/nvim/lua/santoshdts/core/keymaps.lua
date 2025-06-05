vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move a single ine above in visual mode
keymap.set("v", "K", ":m '>-2<CR>gv=gv") -- Move a single line below in visual mode
-- New Tmux session from nvim editor
keymap.set("n", "<C-p>", "<cmd>silent !tmux split-window -v -l 15<CR>")
keymap.set("n", "<C-n>", "<cmd>silent !tmux new-window<CR>")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- save all, just like VSCode Ctrl+s // Conflicting with Tmux Prefix key
-- keymap.set("n", "<C-s>", "<cmd>w<cr><cmd>wa<cr>", { desc = "Save all" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<Esc>", function()
	require("notify").dismiss()
end, { desc = "dismiss notify popup and clear hlsearch" })
