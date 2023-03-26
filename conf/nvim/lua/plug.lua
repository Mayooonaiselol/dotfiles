local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  print('Installing Packer')
  cmd(':!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[ packadd packer.nvim ]]

cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

require('packer').startup {
  function()
    use 'wbthomason/packer.nvim'
    use 'Pocco81/true-zen.nvim'

    -- On buffer stuff
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
    }

    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end,
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('plug.indentline')
      end,
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      requires = { 'nathom/filetype.nvim' },
      config = function()
        require('plug.treesitter')
      end
    }

    -- UI
    use 'RRethy/nvim-base16'

    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('plug.gitsigns')
      end,
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('plug.telescope')
      end,
    }

    -- Completion
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup()
      end
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end,
    }
  end,

  config = {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'single' }
      end,
      prompt_border = 'single',
    },
  },
}
