return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
          },
        },
        indent_markers = { enable = false },
      },
    })

    local api = require("nvim-tree.api")
    vim.keymap.set("n", "<leader>e", api.tree.toggle)
  end
}
