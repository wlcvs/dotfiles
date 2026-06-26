# dotfiles

Personal configuration for **Fedora 44 Sway** on a ThinkPad.

## Design

Monochromatic HUD aesthetic — only black, white, and gray. No icons, no emojis, no colors anywhere. JetBrains Mono system-wide. Sharp edges, no rounded corners.

## Stack

| Role | Tool |
|---|---|
| Login manager | greetd + tuigreet |
| Compositor | Sway |
| Screen lock | swaylock + swayidle |
| Terminal | Alacritty + tmux |
| Shell | zsh + Powerlevel10k |
| Editor | Neovim (lazy.nvim) + VS Code |
| Launcher | Rofi |
| Bar | Waybar |
| Notifications | Dunst |
| Screenshots | Grimshot (grim + slurp) |
| Audio | PipeWire + pulsemixer |
| File manager | yazi |
| Bluetooth | bluetuith |
| Network | nmtui |
| System monitor | btop |
| Git TUI | lazygit |
| Docker TUI | lazydocker |
| Browser | Google Chrome |
| Notes | Obsidian (Flatpak) |
| Music | Spotify (Flatpak) |
| Containers | Docker |

## Installation

```bash
git clone https://github.com/wlcvs/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

After installing, open Neovim — plugins install automatically on first launch.

> **Note:** Docker group membership and logind power config require a reboot to take effect.

## VS Code

Theme: **[QUENCH](https://github.com/wlcvs/quench)** — monochromatic, black/white/gray only, no color anywhere.

Install the extension locally (included in `install.sh`) or from the marketplace:

```
ext install wlcvs.quench
```

## TUI Apps (available in Rofi via Super+D)

| App | Description |
|---|---|
| **yazi** | File manager with image preview |
| **pulsemixer** | Audio mixer |
| **bluetuith** | Bluetooth manager |
| **btop** | System monitor |
| **nmtui** | Network manager |
| **lazygit** | Git client |
| **lazydocker** | Docker manager |

## CLI Tools

| Tool | Replaces | Description |
|---|---|---|
| `eza` | `ls` | Modern ls with git status |
| `bat` | `cat` / `less` | Syntax highlighting pager |
| `fzf` | — | Fuzzy finder (`Ctrl+R` history, `Ctrl+T` files) |
| `zoxide` | `cd` | Smart directory jumper |
| `jq` | — | JSON processor |
| `gum` | — | Pretty shell script components |
| `dua` | `du` | Disk usage analyzer (TUI) |
| `fastfetch` | neofetch | System info |
| `tldr` | `man` | Simplified man pages |
| `ripgrep` | `grep` | Fast recursive search |
| `fd` | `find` | Fast file finder |
| `mpv` | — | Media player |
| `imagemagick` | — | Image processing CLI |

## Shell Aliases

| Alias | Command |
|---|---|
| `n` | `nvim` |
| `lg` | `lazygit` |
| `ldk` | `lazydocker` |
| `ll` | `eza -lah --git` |
| `lt` | `eza --tree` |
| `cat` | `bat --paging=never` |
| `du` | `dua` |
| `fetch` | `fastfetch` |
| `cd` | `zoxide` |

## Keybindings — Sway

| Shortcut | Action |
|---|---|
| `Super+Enter` | Open Alacritty (new tmux window) |
| `Super+D` | App launcher (Rofi — apps only) |
| `Super+Shift+Q` | Close window |
| `Super+Shift+E` | Power menu (lock / logout / suspend / reboot / shutdown) |
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

| Key | Action |
|---|---|
| `<C-s>` | Save file |
| `<C-q>` | Quit |
| `<Leader>e` | Toggle file explorer |
| `<Leader>fmt` | Format buffer |
| `<Leader>ff` | Find files (Telescope) |
| `<Leader>fg` | Live grep (Telescope) |
| `<Leader>fb` | List buffers |
| `<Leader>a` | Harpoon add file |
| `<C-e>` | Harpoon quick menu |

## Keyboard

- Layout: **Portuguese Brazil (ThinkPad ABNT2)**
- `Caps Lock` → `Esc`
- `Esc` → `Caps Lock`
