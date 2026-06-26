# dotfiles

Base configuration for **CachyOS** — WM-agnostic.

> WM-specific layers: [dotfiles-qtile](https://github.com/wlcvs/dotfiles-qtile) · [dotfiles-sway](https://github.com/wlcvs/dotfiles-sway)
> Neovim: [nvim](https://github.com/wlcvs/nvim)

## Design

Monochromatic — only black, white, and gray. JetBrains Mono system-wide. No icons, no rounded corners.

## Stack

| Role | Tool |
|---|---|
| Terminal | Alacritty + tmux |
| Shell | zsh + Powerlevel10k |
| Editor | Neovim (see [wlcvs/nvim](https://github.com/wlcvs/nvim)) + VS Code |
| Launcher | Rofi |
| Notifications | Dunst |
| Clipboard history | cliphist + fzf |
| File manager | yazi |
| Audio | PipeWire + pulsemixer |
| Bluetooth | bluetuith |
| Network | nmtui |
| System monitor | btop |
| Git TUI | lazygit |
| Docker TUI | lazydocker |
| Browser | Google Chrome |

## Installation

```bash
git clone https://github.com/wlcvs/dotfiles ~/dotfiles
chmod +x ~/dotfiles/install.sh
~/dotfiles/install.sh
```

After installing:
```bash
# Neovim
git clone https://github.com/wlcvs/nvim ~/.config/nvim
nvim  # plugins install on first launch

# WM layer (pick one)
git clone https://github.com/wlcvs/dotfiles-qtile ~/dotfiles-qtile && ~/dotfiles-qtile/install.sh
# or
git clone https://github.com/wlcvs/dotfiles-sway ~/dotfiles-sway && ~/dotfiles-sway/install.sh
```

## VS Code

Theme: **[QUENCH](https://github.com/wlcvs/quench)** — monochromatic, no color anywhere.

```
ext install wlcvs.quench
```

## TUI Apps (Rofi via Super+D)

| App | Description |
|---|---|
| yazi | File manager |
| pulsemixer | Audio mixer |
| bluetuith | Bluetooth manager |
| btop | System monitor |
| nmtui | Network manager |
| lazygit | Git client |
| lazydocker | Docker manager |

## CLI Tools

| Tool | Replaces |
|---|---|
| `eza` | `ls` |
| `bat` | `cat` / `less` |
| `fzf` | fuzzy finder |
| `zoxide` | `cd` |
| `ripgrep` | `grep` |
| `fd` | `find` |
| `dua` | `du` |
| `fastfetch` | neofetch |

## Shell Aliases

| Alias | Command |
|---|---|
| `n` | `nvim` |
| `lg` | `lazygit` |
| `ldk` | `lazydocker` |
| `ll` | `eza -lah --git` |
| `lt` | `eza --tree` |
| `cat` | `bat --paging=never` |
| `cd` | `zoxide` |

## Keybindings — tmux

Prefix: `Ctrl+A`

| Shortcut | Action |
|---|---|
| `Prefix + \|` | Vertical split |
| `Prefix + -` | Horizontal split |
| `Prefix + C` | New window |
| `Alt+Arrow` | Navigate panes |
| `Prefix + R` | Reload config |
