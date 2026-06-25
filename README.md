# dotfiles

Personal configuration for **Fedora 44 Sway** on a ThinkPad.

## Stack

| Role | Tool |
|---|---|
| Compositor | Sway |
| Terminal | Alacritty + tmux |
| Shell | zsh + Powerlevel10k |
| Editor | Neovim (lazy.nvim) |
| Launcher | Rofi |
| Bar | Waybar |
| Notifications | Dunst |
| Screenshots | Grimshot (grim + slurp) |
| Audio | PipeWire + pulsemixer |
| File manager | yazi |
| Bluetooth | bluetuith |
| Network | nmtui |
| System monitor | btop |
| Browser | Google Chrome |
| Theme | Catppuccin Mocha |

## Installation

```bash
git clone https://github.com/wlcvs/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

After installing, run `p10k configure` to set up the prompt style, then open Neovim — plugins install automatically on first launch.

## TUI Apps (available in Rofi via Super+D)

| App | Description |
|---|---|
| **yazi** | File manager with image preview |
| **pulsemixer** | Audio mixer |
| **bluetuith** | Bluetooth manager |
| **btop** | System monitor |
| **nmtui** | Network manager |

## Keybindings — Sway

| Shortcut | Action |
|---|---|
| `Super+Enter` | Open Alacritty (with tmux) |
| `Super+D` | App launcher (Rofi — apps only) |
| `Super+Shift+Q` | Close window |
| `Super+Shift+E` | Exit Sway |
| `Super+Shift+C` | Reload config |
| `Super+F` | Fullscreen |
| `Super+Shift+Space` | Toggle floating |
| `Super+1..0` | Switch workspace |
| `Super+Shift+1..0` | Move window to workspace |
| `Super+H/J/K/L` | Focus (vim-style) |
| `Super+Shift+H/J/K/L` | Move window |
| `Super+B` | Split horizontal |
| `Super+V` | Split vertical |
| `Super+R` | Resize mode |
| `Super+Minus` | Scratchpad |

## Keybindings — Screenshots

| Shortcut | Action |
|---|---|
| `Print` | Select area → clipboard |
| `Alt+Print` | Active window → clipboard |
| `Ctrl+Print` | Full screen → clipboard |
| `Shift+Print` | Full screen → saves to `~/Imagens` |

## Keybindings — tmux

Prefix: `Ctrl+A`

| Shortcut | Action |
|---|---|
| `Prefix + \|` | Vertical split |
| `Prefix + -` | Horizontal split |
| `Prefix + C` | New window |
| `Alt+Arrow` | Navigate panes |
| `Prefix + R` | Reload config |

## Keybindings — Neovim

Leader key: `Space`

### General

| Key | Action |
|---|---|
| `<C-s>` | Save file |
| `<C-q>` | Quit |
| `<Leader>e` | Toggle file explorer |
| `<Leader>fmt` | Format buffer |

### Telescope

| Key | Action |
|---|---|
| `<Leader>ff` | Find files |
| `<Leader>fg` | Live grep |
| `<Leader>fb` | List buffers |
| `<Leader>fh` | Help tags |

### Harpoon

| Key | Action |
|---|---|
| `<Leader>a` | Add file |
| `<Leader>r` | Remove file |
| `<C-e>` | Quick menu |
| `<C-p>` / `<C-n>` | Previous / next file |

### Autocomplete

| Key | Action |
|---|---|
| `<C-Space>` | Trigger autocomplete |
| `<CR>` | Confirm selection |
| `<Tab>` / `<S-Tab>` | Next / previous item |

## Keyboard

- Layout: **Portuguese Brazil (ThinkPad ABNT2)**
- `Caps Lock` → `Esc`
- `Esc` → `Caps Lock`
