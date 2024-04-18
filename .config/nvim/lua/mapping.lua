-- mapleader -> Space
vim.g.mapleader = " "

local b = vim.keymap.set
local opts = { noremap = true, silent = true }

-- for move in movements
b({ "n", "v" }, "j", "gj", opts)
b({ "n", "v" }, "k", "gk", opts)

-- disable highlight when ESC is pressed
-- b({ "i", "v", "n" }, "<ESC>", "<ESC>:noh<CR>", opts)
b({ "i", "v", "n" }, "<ESC>", "<ESC>:noh<CR>:w<CR>", opts) -- NOTE: with save

--
-- copy all text in system buffer
-- b("n", "<leader>Y", "<Cmd>%y+<CR>", opts)

-- system buffer operation
b({ "n", "v" }, "<leader>y", '"+y', opts) -- NOTE: for wayland need install wl-copy
b({ "n", "v" }, "<leader>Y", '"+Y', opts)
b({ "n", "v" }, "<leader>p", '"+p', opts)
b({ "n", "v" }, "<leader>P", '"+P', opts)

-- delete tab
b("n", "Q", "<cmd>q<cr>", opts)
-- b("n", "Q", "<cmd>tabclose<cr>", opts)

-- CUSTOM EXIT
b({ "n", "v" }, "ZZ", "<ESC><CMD>qall<CR>", opts)
b({ "n", "v" }, "ZQ", "<ESC><CMD>qall!<CR>", opts)

-- remap <c-q> -> q
b("n", "<c-q>", "q", opts)
b("n", "q", "<Nop>", opts)

-- b("n", "<F9>", "<cmd>make test<cr>", opts)
b("i", "<c-e>", "<c-o>de", opts)

b("n", ";h", ":split<cr>", opts) -- horizontal
b("n", ";v", ":vsplit<cr>", opts) -- vertical
b("n", ";n", ":tabedit<cr>", opts) -- new tab
b("n", ";d", "<ESC>my<cmd>tabnew %<cr><esc>'yzz", opts) -- duplicate tab

-- vim.api.nvim_set_keymap("x", "p", '"_dP', { noremap = true, silent = true }) -- Отключить копирование замененного текста в <visual mode>
-- vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true, silent = true }) -- Отключить копирование удаленного текста в <normal mode>
-- vim.api.nvim_set_keymap("x", "d", '"_d', { noremap = true, silent = true }) -- Отключить копирование удаленного текста в <visual mode>
-- vim.api.nvim_set_keymap("n", ".", "<Nop>", { silent = true }) -- Отключить повторение действия через символ '.'
-- TODO:
-- tab  // tab is same ctrl+i
-- s-tab
-- ss
-- s+another_key
