-- pick a filetree

return {
  -- NERDTree: better file-tree browsing
  {"scrooloose/nerdtree",
    lazy = false,
    enabled = false,
    dependencies = {
      "ryanoasis/vim-devicons",
      "tiagofumo/vim-nerdtree-syntax-highlight",
    },
    init = function()
      -- open with <leader>-n
      vim.keymap.set('n', '<Leader>n', '<CMD>NERDTreeToggle<CR>')
      -- ignore files in NERDTree
      vim.g.webdevicons_conceal_nerdtree_brackets = true
      vim.g.webdevicons_enable_nerdtree = true
      vim.g.NERDTreeIgnore = { '.pyc$', '~$' }
      vim.g.__std_in = false
      vim.api.nvim_create_autocmd("StdinReadPre", {
	callback = function()
          vim.g.__std_in = true
	end
      });
      vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
          -- open if no file specified, or if directory specified
	  if not vim.g.__std_in then
	    if vim.fn.argc() == 0 then
              vim.cmd.NERDTree()
            else
              local dir = vim.fn.expand(vim.fn.argv()[1])
              if vim.fn.isdirectory(dir) == 1 then
                vim.cmd.NERDTree(dir)
	        vim.cmd.wincmd("p")
		vim.cmd.enew()
		vim.cmd.cd(dir)
	      end
            end
	  end
	end
      });
    end,
  },

  {"nvim-tree/nvim-tree.lua",
    lazy = false,
    enabled =  not vim.g.started_by_firenvim,
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function(plugin, opts)
      -- no idea why this is required... default doesn't work
      require('nvim-tree').setup(opts)
    end,
    init = function()
      -- disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- open with <leader>-n
      vim.keymap.set('n', '<Leader>n', ':NvimTreeToggle<CR>')
      vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
          -- open if no file specified, or if directory specified
	  if not vim.g.__std_in then
	    if vim.fn.argc() == 0 then
              vim.cmd.NvimTreeOpen()
            else
              local dir = vim.fn.expand(vim.fn.argv()[1])
              if vim.fn.isdirectory(dir) == 1 then
                vim.cmd.NvimTreeOpen(dir)
	        vim.cmd.wincmd("p")
		vim.cmd.enew()
		vim.cmd.cd(dir)
	      end
            end
	  end
	end
      });
    end,
  },
}
