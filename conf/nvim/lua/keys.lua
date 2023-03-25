--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

-- Normal --
-- Faster Command Line
keymap("n", ";", ":", opts_nosilent)
keymap("n", "<leader>o", ":e ", opts_nosilent)

-- Split
keymap("n", "hs", ":split<CR>", opts)
keymap("n", "vs", ":vs<CR>", opts)

-- Save and quit
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("n", "<C-q>", ":q<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>a", opts)

-- Buffer
keymap("n", "<leader>x", ":bd<CR>", opts)
keymap("n", "<leader>s", ":w<CR>", opts)
keymap("n", "<C-t>", ":enew<CR>", opts)
keymap("n", "<ESC>", ":nohlsearch<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

keymap("i", "<C-E>", "<End>", opts)
keymap("i", "<C-A>", "<Home>", opts)

-- Terminal --
keymap("n", "<leader>v", ":vs +terminal | startinsert<CR>", opts)
keymap("n", "<leader>h", ":split +terminal | startinsert<CR>", opts)

-- Extensions --

-- <Telescope> --
keymap("n", "<leader>b", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>ff", ":Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<leader>:", ":Telescope commands<CR>", opts)
keymap("n", "<leader>so", ":Telescope diagnostics<CR>", opts)

-- Misc --
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>t", ":TroubleToggle workspace_diagnostics<CR>", opts)

-- Python --
keymap("n", "<leader>r", ":split<CR> :terminal python %<CR>", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
