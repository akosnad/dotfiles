vim.g.mapleader = ','

-- Quitting, saving
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>W', '<cmd>w !sudo tee % >/dev/null<cr>')

vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')
vim.keymap.set('n', '<leader>Q', '<cmd>q!<cr>')

vim.keymap.set('n', '<leader>x', '<cmd>x<cr>')

-- Buffers
vim.keymap.set('n', '<silent><leader>,', '<cmd>b#<cr>')

-- Tabs
vim.keymap.set('n', '<leader>t', '<cmd>tabnew<cr>')

-- Clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"*y')

vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"*p')

-- Splitting
vim.keymap.set('n', '<leader>v', '<cmd>vsplit<cr>')
vim.keymap.set('n', '<leader>s', '<cmd>split<cr>')

-- Window navigation
vim.keymap.set('n', '<M-Left>', '<C-W>h')
vim.keymap.set('n', '<M-Right>', '<C-W>l')
vim.keymap.set('n', '<M-Up>', '<C-W>k')
vim.keymap.set('n', '<M-Down>', '<C-W>j')

vim.keymap.set('n', '<M-Left>', '<C-W>h')
vim.keymap.set('n', '<M-Right>', '<C-W>l')
vim.keymap.set('n', '<M-Up>', '<C-W>k')
vim.keymap.set('n', '<M-Down>', '<C-W>j')

vim.keymap.set('n', '<leader><Left>', '<C-W>H')
vim.keymap.set('n', '<leader><Right>', '<C-W>L')
vim.keymap.set('n', '<leader><Up>', '<C-W>K')
vim.keymap.set('n', '<leader><Down>', '<C-W>J')

vim.keymap.set('n', '<S-Left>', '<C-W>>')
vim.keymap.set('n', '<S-Right>', '<C-W><')
vim.keymap.set('n', '<S-Up>', '<C-W>-')
vim.keymap.set('n', '<S-Down>', '<C-W>+')
