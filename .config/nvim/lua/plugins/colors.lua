return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = {
                    normal = {
                        a = { fg = "#e4e4e7", bg = "#27272a", gui = "bold" },
                        b = { fg = "#71717a", bg = "#111111" },
                        c = { fg = "#3f3f46", bg = "#0a0a0a" },
                    },
                    insert = {
                        a = { fg = "#0a0a0a", bg = "#a1a1aa", gui = "bold" },
                        b = { fg = "#71717a", bg = "#111111" },
                        c = { fg = "#3f3f46", bg = "#0a0a0a" },
                    },
                    visual = {
                        a = { fg = "#0a0a0a", bg = "#71717a", gui = "bold" },
                        b = { fg = "#71717a", bg = "#111111" },
                        c = { fg = "#3f3f46", bg = "#0a0a0a" },
                    },
                    replace = {
                        a = { fg = "#e4e4e7", bg = "#3f3f46", gui = "bold" },
                        b = { fg = "#71717a", bg = "#111111" },
                        c = { fg = "#3f3f46", bg = "#0a0a0a" },
                    },
                    command = {
                        a = { fg = "#e4e4e7", bg = "#18181b", gui = "bold" },
                        b = { fg = "#71717a", bg = "#111111" },
                        c = { fg = "#3f3f46", bg = "#0a0a0a" },
                    },
                    inactive = {
                        a = { fg = "#3f3f46", bg = "#0a0a0a" },
                        b = { fg = "#3f3f46", bg = "#0a0a0a" },
                        c = { fg = "#3f3f46", bg = "#0a0a0a" },
                    },
                },
                icons_enabled = false,
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
    {
        "nvim-tree/nvim-web-devicons",
        enabled = false,
    },
}
