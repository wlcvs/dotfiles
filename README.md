# dotfiles

Base configuration — shell, terminal, editor tools. WM-agnostic.

> WM layers: [dotfiles-sway](https://github.com/wlcvs/dotfiles-sway) · [dotfiles-qtile](https://github.com/wlcvs/dotfiles-qtile)
> Editor: [nvim](https://github.com/wlcvs/nvim)

## Design

Monochromatic — only black, white, and gray. JetBrains Mono system-wide. No icons, no rounded corners.

## Stack

| Role | Tool |
|---|---|
| Terminal | Alacritty + tmux |
| Shell | zsh + Powerlevel10k |
| Editor | Neovim ([wlcvs/nvim](https://github.com/wlcvs/nvim)) + VS Code |
| File manager | yazi |
| Audio | PipeWire + pulsemixer |
| Bluetooth | bluetuith |
| Network | nmtui |
| System monitor | btop |
| Git TUI | lazygit |
| Docker TUI | lazydocker |

## Installation

### 1. Install packages

**Arch**
```bash
sudo pacman -S --needed \
  alacritty tmux neovim zsh git curl unzip \
  ttf-jetbrains-mono \
  brightnessctl playerctl wl-clipboard \
  fzf ripgrep fd bat jq \
  lazygit python-pip

yay -S --needed \
  eza zoxide cliphist lazydocker \
  gum dua-cli fastfetch tldr mpv imagemagick
```

**Debian / Ubuntu**
```bash
sudo apt install \
  alacritty tmux neovim zsh git curl unzip \
  fonts-jetbrains-mono \
  brightnessctl playerctl wl-clipboard \
  fzf ripgrep fd-find bat jq \
  python3-pip

# Manually install: eza, zoxide, lazygit, lazydocker, cliphist
# See each tool's GitHub releases page
```

**Fedora**
```bash
sudo dnf install \
  alacritty tmux neovim zsh git curl unzip \
  jetbrains-mono-fonts \
  brightnessctl playerctl wl-clipboard \
  fzf ripgrep fd-find bat jq \
  lazygit python3-pip

# AUR equivalents via COPR or manual install: eza, zoxide, lazydocker, cliphist
```

### 2. Run install script
```bash
git clone https://github.com/wlcvs/dotfiles ~/dotfiles
chmod +x ~/dotfiles/install.sh
~/dotfiles/install.sh
```

### 3. Install Neovim config
```bash
git clone https://github.com/wlcvs/nvim ~/.config/nvim
nvim  # plugins install automatically on first launch
```

### 4. Install a WM layer
```bash
# Qtile
git clone https://github.com/wlcvs/dotfiles-qtile ~/dotfiles-qtile && ~/dotfiles-qtile/install.sh

# or Sway
git clone https://github.com/wlcvs/dotfiles-sway ~/dotfiles-sway && ~/dotfiles-sway/install.sh
```

## VS Code

Theme: **[QUENCH](https://github.com/wlcvs/quench)** — monochromatic, no color anywhere.

```
ext install wlcvs.quench
```

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

## Scripts (`~/.local/bin`)

| Script | Description |
|---|---|
| `clipboard` | Clipboard history — cliphist + fzf (Wayland) |
| `volume-tui` | Curses volume control via wpctl |
| `power-profile` | Cycle power profiles via busctl |

## tmux keybindings

Prefix: `Ctrl+A`

| Shortcut | Action |
|---|---|
| `Prefix + \|` | Vertical split |
| `Prefix + -` | Horizontal split |
| `Prefix + C` | New window |
| `Alt+Arrow` | Navigate panes |
| `Prefix + R` | Reload config |
