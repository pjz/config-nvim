-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Rainbow colored delimiters for easier matching
  'HiPhish/rainbow-delimiters.nvim',
       
  -- Easer tag usage
  {"majutsushi/tagbar",
    init = function()
      vim.g.tagbar_left = 1
      -- easy access to the taglist
      vim.keymap.set('n', '<Leader>t', ':TagbarToggle<CR>')
      vim.g.tagbar_type_zig = {
        ctagstype = 'zig',
        kinds = {
          'f:functions',
          's:structs',
          'e:enums',
          'u:unions',
          'E:errors'
        }
      }
    end,
  },

  -- C-a/C-x to inc/dec dates and times
  "tpope/vim-speeddating",
  -- surround text with delimiters
  "tpope/vim-surround",
  -- and allow using . to repeat it
  "tpope/vim-repeat",

  -- sync with direnv
  "direnv/direnv.vim",


}
