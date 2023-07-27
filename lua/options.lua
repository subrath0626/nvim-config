vim.o.clipboard = 'unnamedplus'
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.swapfile = false
vim.g.mapleader = " "

local key = vim.keymap.set

key('n', '<c-s>', '<cmd>w<cr>')
key('i', '<c-s>', '<esc><cmd>w<cr>')
