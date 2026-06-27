# dotfiles

Base configuration — shell, terminal, tools and apps. WM-agnostic.

> WM layer: [dotfiles-sway](https://github.com/wlcvs/dotfiles-sway)
> Editor: [nvim](https://github.com/wlcvs/nvim)

## Design

Monochromatic — only black, white, and gray. JetBrains Mono system-wide.

## What's included

### Shell & terminal
| Tool | Description |
|---|---|
| zsh + Powerlevel10k | Shell with minimal ASCII prompt |
| tmux | Terminal multiplexer, prefix `Ctrl+A` |
| Alacritty | Terminal — JetBrains Mono, zinc palette |

### TUI tools
| Tool | Description |
|---|---|
| yazi | File manager |
| pulsemixer | Audio mixer (PipeWire) |
| lazygit | Git client |
| lazydocker | Docker manager |
| btop | System monitor |
| bluetuith | Bluetooth manager |
| nmtui | Network manager |
| fzf | Fuzzy finder (`Ctrl+R`, `Ctrl+T`) |
| zoxide | Smart `cd` |
| eza | Modern `ls` |
| bat | `cat` with syntax highlight |
| ripgrep | Fast grep |
| fd | Fast find |
| dua | Disk usage analyzer |
| gum | Pretty shell scripts |
| fastfetch | System info |
| tldr | Simplified man pages |
| mpv | Media player |

### GUI apps
| App | Install method |
|---|---|
| Google Chrome | Package manager (see below) |
| Spotify | Flatpak |
| Obsidian | Flatpak |
| Claude Code | npm |

### Other
| Item | Description |
|---|---|
| DMZ-White cursor | Classic white cursor, installed to `~/.local/share/icons/DMZ-White` |

---

## Installation

```bash
git clone https://github.com/wlcvs/dotfiles ~/dotfiles && bash ~/dotfiles/install.sh
```

### 1. Install packages for your distro

**Arch**
```bash
sudo pacman -S --needed \
  alacritty tmux zsh git curl unzip \
  ttf-jetbrains-mono \
  nodejs npm \
  flatpak \
  fzf ripgrep fd bat jq python-pip \
  lazygit

yay -S --needed \
  lazydocker zoxide gum dua-cli fastfetch tldr mpv imagemagick \
  btop bluetuith
```

### 2. Run install script
```bash
git clone https://github.com/wlcvs/dotfiles ~/dotfiles && bash ~/dotfiles/install.sh
```

The script handles:
- Installs all packages via pacman and AUR helper (paru/yay)
- Powerlevel10k clone
- Symlinking shell/terminal configs
- Flatpak: Spotify, Obsidian
- Google Chrome (AUR)
- VS Code (AUR)
- Claude Code (curl installer)

## Shell aliases

| Alias | Command |
|---|---|
| `n` | `nvim` |
| `lg` | `lazygit` |
| `ldk` | `lazydocker` |
| `ll` | `eza -lah --git` |
| `lt` | `eza --tree` |
| `cat` | `bat --paging=never` |
| `cd` | `zoxide` |
| `du` | `dua` |
| `fetch` | `fastfetch` |

## tmux keybindings

Prefix: `Ctrl+A`

| Shortcut | Action |
|---|---|
| `Prefix + \|` | Vertical split |
| `Prefix + -` | Horizontal split |
| `Prefix + C` | New window |
| `Alt+Arrow` | Navigate panes |
| `Prefix + R` | Reload config |
