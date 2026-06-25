return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},

	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.lsp.config("*", {
			capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				cmp_nvim_lsp.default_capabilities()
			),
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "Lua 5.1" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		vim.lsp.enable("lua_ls", true)
		vim.lsp.enable("pyright", true)
		vim.lsp.enable("ts_ls", true)
		vim.lsp.enable("rust_analyzer", true)
		vim.lsp.enable("clangd", true)
		vim.lsp.enable("gopls", true)
		vim.lsp.enable("html", true)
		vim.lsp.enable("cssls", true)
		vim.lsp.enable("emmet_language_server", true)
		vim.lsp.enable("sqlls", true)
		vim.lsp.enable("yamlls", true)
		vim.lsp.enable("jsonls", true)
		vim.lsp.enable("marksman", true)
	end,
}
