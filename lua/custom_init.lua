

-- easy grep-for-last-yank
vim.keymap.set('', '<C-s>', ':grep "<c-r>"" <CR>')
vim.keymap.set('v', '<C-s>', 'y:grep "<c-r>"" <CR>')

--" Don't use Ex mode, use Q for formatting
vim.keymap.set('', 'Q', 'gq')

-- Press ^L to turn off highlighting and clear any message already displayed.
vim.keymap.set('n', '<C-l>', ':nohlsearch<Bar>:echo<CR>', { silent = true })

vim.g.awk_is_gawk = 1


-- When editing a file, always jump to the last known cursor position.
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  desc = [[
 When editing a file, always jump to the last known cursor position.
 Don't do it when the position is invalid or when inside an event handler
 (happens when dropping a file on gvim).
 Also don't do it when the mark is in the first line, that is the default
 position when opening a file.
  ]],
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! "g`\"')
    end
  end
})


-- " Convenient command to see the difference between the current buffer and the
-- " file it was loaded from, thus the changes you made.
-- " Only define it when not defined already.
if vim.fn.exists(":DiffOrig") == 0 then
  vim.api.nvim_create_user_command('DiffOrig',
    function(_)
      vim.cmd.vnew()
      vim.b.bt = "nofile"
      vim.cmd.read('#')
      vim.cmd('0d_')
      vim.cmd.diffthis()
      vim.cmd.wincmd("p")
      vim.cmd.diffthis()
    end,
    {}
  )
end

-- Misc commands, mostly custom


-- make buffers easier to use - this instead of minibufexplorer
-- and other hacks b/c those always take screenspace
-- - show list of buffers and let you pick a number
vim.keymap.set('n', '<Leader>b', ':buffers<CR>:b')
-- - fast switch to previous buffer
vim.keymap.set('n', '<Leader>B', ':b#<CR>')

vim.keymap.set('n', '<Leader>b', '<CMD>Telescope buffers<CR>')
 


-- make the quickfix list easier use
vim.keymap.set({'n','n'}, '<Leader>q', function ()
  if #vim.fn.filter(vim.fn.getwininfo(), 'v:val.quickfix') == 0 then
    vim.cmd.copen()
  else
    vim.cmd.cclose()
  end
end)

-- make the loclist easier to use
vim.keymap.set({'n', 'n'}, '<Leader>l', function()
  if #vim.fn.filter(vim.fn.getwininfo(), 'v:val.loclist') == 0 then
    vim.cmd.lopen()
  else
    vim.cmd.lclose()
  end
end)

local closer = vim.api.nvim_create_augroup('closer', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = closer,
  pattern = '*',
  desc = 'close if quickfix/loclist are only windows left',
  callback = function()
  local autoclosable = 0
  local windows = vim.fn.getwininfo()
  for _, win in ipairs(windows) do
    if win.loclist == 1  or win.quickfix == 1 then
      autoclosable = autoclosable + 1
    end
  end
  if autoclosable == #windows then
    vim.cmd.quit()
  end
end
})




