---@type MappingsTable
local M = {}

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
  },
  i = {
    ["<C-s>"] = { "<esc><cmd>w<CR>", "save file" },
  },
  t = { ["<Esc>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },
}

-- more keybinds!

return M
