

autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 250 })
	end,
})

cmd[[
autocmd TermOpen * startinsert
autocmd TermOpen * :set nonumber norelativenumber
autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>]]

