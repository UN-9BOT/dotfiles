---@diagnostic disable-next-line: undefined-global

-- mapleader -> Space
vim.g.mapleader = " "

local b = vim.keymap.set
local opts = { noremap = true, silent = true }

-- for move in movements
b({ "n", "v" }, "j", "gj", opts)
b({ "n", "v" }, "k", "gk", opts)

-- for move in windows
b("n", "<c-h>", "<C-w>h", opts)
b("n", "<c-j>", "<C-w>j", opts)
b("n", "<c-k>", "<C-w>k", opts)
b("n", "<c-l>", "<C-w>l", opts)
--

-- move in insert mode
b("i", "<c-h>", "<left>", opts)
b("i", "<c-j>", "<down>", opts)
b("i", "<c-k>", "<up>", opts)
b("i", "<c-l>", "<right>", opts)

-- disable highlight when ESC is pressed
b({ "i", "v", "n" }, "<ESC>", "<ESC>:noh<CR>:w<CR>", opts)

--
-- copy all text in system buffer
-- b("n", "<leader>Y", "<Cmd>%y+<CR>", opts)

-- system buffer operation
b({ "n", "v" }, "<leader>y", '"+y', opts)
b({ "n", "v" }, "<leader>p", '"+p', opts)
b({ "n", "v" }, "<leader>P", '"+P', opts)

-- delete buffer
-- b("n", "Q", "<cmd>lua MiniBufremove.delete()<cr>", opts)

-- delete tab
b("n", "Q", "<cmd>q<cr>", opts)

-- для + - перемещения
b("n", "=", "+", opts)

-- save session
-- b({ "n", "v" }, "ZZ", "<ESC><CMD>Neotree close<CR><cmd>SessionSave<cr>ZZ", opts)
-- b({ "n", "v" }, "ZQ", "<ESC><CMD>Neotree close<CR><cmd>SessionSave<cr>ZQ", opts)
-- b({ "n", "v" }, "ZZ", "<ESC><CMD>qall<cr>", opts)
-- b({ "n", "v" }, "ZQ", "<ESC><CMD>qall<cr>", opts)

local function close_test_ui()
  vim.cmd [[Neotest summary close]]
  require 'dapui'.close()
end

local function save_session()
  vim.cmd [[SessionSave]]
end

local function close_save()
  vim.cmd [[qall]]
end

local function close_no_save()
  vim.cmd [[qall!]]
end

local function ZZ()
  vim.api.nvim_input("<Esc>")
  close_test_ui()
  save_session()
  close_save()
end

local function ZQ()
  vim.api.nvim_input("<Esc>")
  close_test_ui()
  save_session()
  close_no_save()
end

b({ "n", "v" }, "ZZ", ZZ, opts)
b({ "n", "v" }, "ZQ", ZQ, opts)

-- remap <c-q> -> q
b("n", "<c-q>", "q", opts)
b("n", "q", "<Nop>", opts)

-- b("n", "<F9>", "<cmd>make test<cr>", opts)
b("i", "<c-e>", "<c-o>de", opts)

b("n", ";h", ":split<cr>", opts)                        -- horizontal
b("n", ";v", ":vsplit<cr>", opts)                       -- vertical
b("n", ";n", ":tabedit<cr>", opts)                      -- new tab
b("n", ";d", "<ESC>my<cmd>tabnew %<cr><esc>'yzz", opts) -- duplicate tab



-- TODO:
-- tab  // tab is same ctrl+i
-- s-tab
-- ss
-- s+another_key
