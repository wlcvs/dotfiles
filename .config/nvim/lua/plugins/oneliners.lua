return {
  { -- This helps with ssh tunnneling and copying to clipboard
    'ojroques/vim-oscyank',
  },

  { -- Git plugin, to use just type :Git blame -w
    'tpope/vim-fugitive', 
  },

  { -- Show CSS Colors
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup({})
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },

--[[
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end
  },
]] 
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "prettier",
          "shfmt",
          "yamlfmt",
          "taplo",
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs", 
    event = "InsertEnter",
    config = true
  },

  {
    "kylechui/nvim-surround",
  },

}
