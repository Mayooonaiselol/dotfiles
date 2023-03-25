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
    use 'glepnir/dashboard-nvim'
    use 'wbthomason/packer.nvim'
    use 'Pocco81/true-zen.nvim'

    -- EWW
    use 'gpanders/nvim-parinfer'
    use 'elkowar/yuck.vim'

    -- On buffer stuff
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
    }

    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      config = function()
        require("nvim-tree").setup()
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

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require('plug.lsp')
      end,
    }

    use {
      "williamboman/nvim-lsp-installer",
      requires = "neovim/nvim-lspconfig",
      config = function()
        require("nvim-lsp-installer").setup({
          ui = {
            icons = {
              server_installed = "",
              server_pending = "",
              server_uninstalled = ""
            }
          }
        })
      end,
    }

    use {
      'hrsh7th/nvim-cmp',
      requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline' },
      config = function()
        require('plug.cmp')
      end,
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end,
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('plug.lualine')
      end,
    }

    use {
      "nvim-neorg/neorg",
      ft = "norg",
      run = ":Neorg sync-parsers",
      after = "nvim-treesitter",
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.norg.concealer"] = {},
          }
        }
      end,
      requires = "nvim-lua/plenary.nvim",
    }

    -- SMOOOTH
    use {
      "karb94/neoscroll.nvim",
      config = function()
        require('plug.neoscroll')
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
