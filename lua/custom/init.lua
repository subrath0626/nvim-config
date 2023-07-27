-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local autocmd = vim.api.nvim_create_autocmd

vim.opt.swapfile = false
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.wo.relativenumber = true
