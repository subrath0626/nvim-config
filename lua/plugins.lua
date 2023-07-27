return {
	{
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
				keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
    opts = {
      close_if_last_window = true,
      popup_border_style = 'rounded',
      enable_git_status = false,
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            'node_modules',
            '.git',
            '.github',
          },
          hide_dotfiles = false,
          always_show = {
            '.gitignored',
          },
        },
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
      },
    },

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  },
	{ 'navarasu/onedark.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      require('onedark').load()
    end,
	},
	  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}, -- this is equalent to setup({}) function
  },
	  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = {}
	},
	  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {  },
        automatic_installation = true,
      }
      local handlers = {
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup {}
        end,
      }
      require('mason-lspconfig').setup_handlers(handlers)
    end,
  },
	{
		'neovim/nvim-lspconfig',
	},
	{
	'hrsh7th/nvim-cmp',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-buffer',
		'saadparwaiz1/cmp_luasnip',
		'L3MON4D3/LuaSnip',
	},
	config = function()
	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
	end

	local cmp = require 'cmp'
	local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
	local luasnip = require 'luasnip'

	cmp.setup.cmdline(':', {
		sources = { --[[ your sources ]]
		},
		enabled = function()
			-- Set of commands where cmp will be disabled
			local disabled = {
				IncRename = true,
			}
			-- Get first word of cmdline
			local cmd = vim.fn.getcmdline():match '%S+'
			-- Return true if cmd isn't disabled
			-- else call/return cmp.close(), which returns false
			return not disabled[cmd] or cmp.close()
		end,
	})

	vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

	cmp.setup {
		snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

		enabled = function()
			-- disable completion in comments
			local context = require 'cmp.config.context'
			-- keep command mode completion enabled when cursor is in a comment
			if vim.api.nvim_get_mode().mode == 'c' then
				return true
			else
				return not context.in_treesitter_capture 'comment' and not context.in_syntax_group 'Comment'
			end
		end,

		-- auto parathensis for methods and functions
		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done()),

		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert {
			['<Tab>'] = function(fallback)
				if not cmp.select_next_item() then
					if vim.bo.buftype ~= 'prompt' and has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end
			end,
			['<S-Tab>'] = function(fallback)
				if not cmp.select_prev_item() then
					if vim.bo.buftype ~= 'prompt' and has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end
			end,

			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		},
		sources = cmp.config.sources {
			{ name = 'nvim_lsp' },
		},
		{
			{ name = 'buffer' },
		},
	}

	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' },
		}, {
			{ name = 'cmdline' },
		}),
	})
end
}
}
