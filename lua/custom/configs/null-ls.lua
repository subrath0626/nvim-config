local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {

	-- webdev stuff
	formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
	formatting.prettierd.with({
		filetypes = { "html", "markdown", "css", "javascript", "typescript", "typescriptreact", "javascriptreact" },
	}), -- so prettier works only on these filetypes

	-- Lua
	formatting.stylua,

	formatting.black,
	formatting.rustfmt,
	formatting.google_java_format.with({ filetypes = { "java" } }),
	formatting.gofumpt,

	-- cpp
	formatting.clang_format,

	lint.eslint_d,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
