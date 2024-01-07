local M = {

	"neoclide/coc.nvim",
	branch = "release",
}

M.config = function()
	-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
	-- delays and poor user experience
	vim.opt.updatetime = 100

	-- Always show the signcolumn, otherwise it would shift the text each time
	-- diagnostics appeared/became resolved
	local b = vim.keymap.set

	b("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

	b("n", "gd", "mD<Plug>(coc-definition)", { silent = true })
	b("n", "gD", ":vsplit<cr><Plug>(coc-definition)", { silent = true })
	b("n", "gt", "<Plug>(coc-type-definition)", { silent = true })
	-- b("n", "gi", "<Plug>(coc-implementation)", { silent = true })
	-- b("n", "gr", "<Plug>(coc-references)", { silent = true })
	b("n", "gr", "<cmd>Telescope coc references<CR>", { silent = true })
	b("n", "gj", vim.diagnostic.open_float, { silent = true })

	b("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })


	function _G.show_docs()
		local cw = vim.fn.expand("<cword>")
		if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
			vim.api.nvim_command("h " .. cw)
		elseif vim.api.nvim_eval("coc#rpc#ready()") then
			vim.fn.CocActionAsync("doHover")
		else
			vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
		end
	end

	b("n", "gk", "<CMD>lua _G.show_docs()<CR>", { silent = true })
	b("n", "<F4>", ":CocCommand editor.action.formatDocument<CR>")

	local opts = { silent = true, nowait = true }
	b("n", "ga", "<Plug>(coc-codeaction-line)", opts)
	b("x", "ga", "<Plug>(coc-codeaction-selected)", opts)
	b("n", "gA", "<Plug>(coc-codeaction-source)", opts)

	b("n", "gy", ":TroubleToggle<CR><c-k>", { silent = true })
	-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
	vim.api.nvim_create_augroup("CocGroup", {})
	vim.api.nvim_create_autocmd("CursorHold", {
		group = "CocGroup",
		command = "silent call CocActionAsync('highlight')",
		desc = "Highlight symbol under cursor on CursorHold"
	})

	b("n", "<leader>c", ":<C-u>CocList -A --normal yank<CR>", { silent = true })


	vim.cmd([[inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>']])


	local function CheckBackspace()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
	end

	vim.g.coc_snippet_next = "<TAB>"
	vim.g.coc_snippet_prev = "<S-TAB>"


	b("n", "<leader>c", ":<C-u>CocList -A --normal yank<CR>", { silent = true })
	vim.cmd([[nnoremap <silent><expr> <leader>i "bea\<BS><c-r>=coc#refresh()\<CR>"]])
	b("n", "<leader>I", "<cmd>Telescope import<CR>", { silent = true })
end


return M
