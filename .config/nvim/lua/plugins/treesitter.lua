return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "lua",
        "php",
        "javascript",
        "markdown",
        "markdown_inline",
        "java",
        "typescript",
        "python",
        "rust",
        "c",
        "cpp",
        "sql",
        "css",
        "html",
        "tsx",
        "haskell",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
