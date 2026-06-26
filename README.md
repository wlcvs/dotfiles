# dotfiles

Base configuration — shell, terminal, tools and apps. WM-agnostic.

> WM layers: [dotfiles-sway](https://github.com/wlcvs/dotfiles-sway) · [dotfiles-qtile](https://github.com/wlcvs/dotfiles-qtile)
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
| DMZ-White cursor | Classic white cursor, installed to `~/.local/share/icons` |
| logind ThinkPad config | Lid close → suspend, power key → suspend |

---

## Installation

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

**Debian / Ubuntu**
```bash
sudo apt install \
  alacritty tmux zsh git curl unzip \
  fonts-jetbrains-mono \
  nodejs npm \
  flatpak \
  fzf ripgrep fd-find bat jq python3-pip \
  btop

# lazygit, lazydocker, zoxide, gum, dua-cli, fastfetch, tldr: install from GitHub releases
# bluetuith: install from https://github.com/bluetuith-org/bluetuith/releases
```

**Fedora**
```bash
sudo dnf install \
  alacritty tmux zsh git curl unzip \
  jetbrains-mono-fonts \
  nodejs npm \
  flatpak \
  fzf ripgrep fd-find bat jq python3-pip \
  lazygit btop

# lazydocker, zoxide, gum, dua-cli, fastfetch, bluetuith: install from GitHub releases or COPR
```

### 2. Run install script
```bash
git clone https://github.com/wlcvs/dotfiles ~/dotfiles
chmod +x ~/dotfiles/install.sh
~/dotfiles/install.sh
```

The script handles:
- Powerlevel10k clone
- DMZ-White cursor theme
- Symlinking shell/terminal configs
- yazi (binary download)
- pulsemixer (pip)
- Flatpak: Spotify, Obsidian
- Google Chrome (detects Arch/Debian/Fedora)
- Claude Code (npm)

### 3. Neovim config
```bash
git clone https://github.com/wlcvs/nvim ~/.config/nvim
nvim  # plugins install on first launch
```

### 4. WM layer
```bash
# Qtile (CachyOS / Arch)
git clone https://github.com/wlcvs/dotfiles-qtile ~/dotfiles-qtile
~/dotfiles-qtile/install.sh

# or Sway
git clone https://github.com/wlcvs/dotfiles-sway ~/dotfiles-sway
~/dotfiles-sway/install.sh
```

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
