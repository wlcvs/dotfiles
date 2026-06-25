# Neovim Config

Minimalist Neovim configuration using Lazy as the plugin manager.

## Requirements

Install the following dependencies before setting up:

| Dependency | Package | Description |
|------------|---------|-------------|
| Neovim >= 0.10 | `neovim` | Text editor |
| Git | `git` | Version control |
| C compiler | `gcc` | For TreeSitter |
| ripgrep | `ripgrep` | For Telescope live_grep |
| fd | `fd` | For Telescope find_files |

### Arch Linux

```bash
sudo pacman -S neovim git gcc ripgrep fd
```

### Debian/Ubuntu

```bash
sudo apt install neovim git build-essential ripgrep fd-find
```

### macOS

```bash
brew install neovim git ripgrep fd
```

## Installation

```bash
git clone git@github.com:wlcvs/nvim.git ~/.config/nvim
nvim
```

On first launch, lazy.nvim installs all plugins automatically. TreeSitter parsers are compiled with gcc in the background — no extra tools required.

## Plugins

### Core

| Plugin | Description |
|--------|-------------|
| **lazy.nvim** | Plugin manager |
| **nvim-lspconfig** | LSP configuration |
| **mason.nvim** | LSP/DAP/Formatter installer |
| **mason-lspconfig.nvim** | Bridge between Mason and LSP config |
| **mason-tool-installer.nvim** | Auto-install formatters |

### Autocomplete

| Plugin | Description |
|--------|-------------|
| **nvim-cmp** | Autocomplete engine |
| **cmp-nvim-lsp** | LSP source for nvim-cmp |
| **cmp-buffer** | Buffer source for nvim-cmp |
| **cmp-path** | Path source for nvim-cmp |
| **cmp-cmdline** | Cmdline source for nvim-cmp |
| **LuaSnip** | Snippet engine |
| **cmp_luasnip** | LuaSnip source for nvim-cmp |
| **friendly-snippets** | Pre-made snippets |

### Formatting

| Plugin | Description |
|--------|-------------|
| **conform.nvim** | Format on save |

### UI

| Plugin | Description |
|--------|-------------|
| **tokyonight.nvim** | Color theme |
| **lualine.nvim** | Status bar |
| **nvim-web-devicons** | Icons |

### Navigation

| Plugin | Description |
|--------|-------------|
| **harpoon2** | Quick file navigation |
| **telescope.nvim** | Fuzzy finder |
| **plenary.nvim** | Dependency for telescope and harpoon |
| **nvim-tree.lua** | File explorer |

### Syntax

| Plugin | Description |
|--------|-------------|
| **nvim-treesitter** | Syntax highlighting |

### Git

| Plugin | Description |
|--------|-------------|
| **vim-fugitive** | Git commands |
| **gitsigns.nvim** | Git signs in signcolumn |

### Utilities

| Plugin | Description |
|--------|-------------|
| **vim-oscyank** | Clipboard via SSH |
| **nvim-highlight-colors** | CSS color highlighting |
| **nvim-autopairs** | Auto pairs (brackets, quotes, etc) |
| **nvim-surround** | Surrounding character manipulation |

## LSP Servers

Automatically installed by Mason:

- lua_ls
- pyright
- ts_ls
- rust_analyzer
- clangd
- gopls
- html
- cssls
- emmet_language_server
- sqlls
- yamlls
- jsonls
- marksman

## Formatters

Automatically installed by Mason:

- stylua (Lua)
- prettier (JS/TS/HTML/CSS)
- shfmt (Shell)
- yamlfmt (YAML)
- taplo (TOML)

Note: rust_analyzer includes built-in formatting for Rust.

## Keybindings

### Global

| Key | Action |
|-----|--------|
| `<Leader>` | `Space` |
| `<C-s>` | Save file |
| `<C-q>` | Quit Neovim |

### File Explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `<Leader>e` | Toggle file explorer |

### Telescope

| Key | Action |
|-----|--------|
| `<Leader>ff` | Find files |
| `<Leader>fg` | Live grep |
| `<Leader>fb` | List buffers |
| `<Leader>fh` | Help tags |

### Harpoon

| Key | Action |
|-----|--------|
| `<Leader>a` | Add current file |
| `<Leader>r` | Remove current file |
| `<Leader>cls` | Clear list |
| `<Leader>fl` | Open list in Telescope |
| `<C-e>` | Quick menu |
| `<C-p>` | Previous file |
| `<C-n>` | Next file |

### Autocomplete (nvim-cmp)

| Key | Action |
|-----|--------|
| `<C-n>` | Next item |
| `<C-p>` | Previous item |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |
| `<C-Space>` | Trigger autocomplete |
| `<CR>` | Confirm selection |
| `<Tab>` | Next item / expand snippet |
| `<S-Tab>` | Previous item / jump back |

### Formatting

| Key | Action |
|-----|--------|
| `<Leader>fmt` | Format buffer |

## Useful Commands

### Mason

```
:Mason              # Open Mason UI
:MasonToolsUpdate   # Update tools
```

### Git (vim-fugitive)

```
:Git blame -w    # View blame without email
```

### LSP

```
:LspInfo              # Show LSP status
:LspRestart          # Restart LSP server
```

### TreeSitter

```
:TSUpdate            # Update parsers
:TSInstall <lang>    # Install specific parser
```
