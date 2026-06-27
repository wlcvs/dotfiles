# CLAUDE.md — dotfiles (base)

Base dotfiles for wlcsv — WM-agnostic configs.
Target machine: CachyOS (Arch-based). WM-specific layers are separate repos.

## Repositories

| Repo | Purpose |
|---|---|
| `wlcvs/dotfiles` | **This repo** — shell, terminal, editor tools, base configs |
| `wlcvs/nvim` | Neovim config (standalone) |
| `wlcvs/dotfiles-sway` | Sway WM layer |

## Design system

Monochromatic HUD aesthetic.

**Palette:**
- bg `#0a0a0a` · surface `#111111` · surface2 `#18181b` · border `#27272a`
- text `#e4e4e7` · muted `#a1a1aa` · dim `#71717a` · faint `#52525b` · subtle `#3f3f46`

**Rules — non-negotiable:**
- Only black, white and gray — no colors anywhere
- Font: JetBrains Mono everywhere
- No rounded corners
- No icons or emojis — text labels only
- No symbols beyond basic ASCII in prompts/UI

## What's in this repo

### Shell (`~/.zshrc`, `~/.p10k.zsh`)
- Powerlevel10k (cloned to `~/.config/powerlevel10k`)
- Prompt: `>` and `<` (ASCII only), gray-only
- `~/.local/bin` in PATH
- eza, bat, zoxide, fzf integrations

### tmux (`~/.tmux.conf`)
- Prefix: `Ctrl+A`
- Mouse on, monochromatic status bar

### Alacritty (`~/.config/alacritty/alacritty.toml`)
- JetBrains Mono 11pt
- All 16 ANSI colors remapped to zinc grayscale
- Reuses tmux session "main" via `tmux new-window`

### Dunst (`~/.config/dunst/dunstrc`)
- No icons, monochromatic, top-right, no rounded corners

### Rofi (`~/.config/rofi/`)
- Minimal zinc popup, no icons, used for app launcher and clipboard

### GTK (`~/.config/gtk-3.0/`, `~/.config/gtk-4.0/`)
- Dark mode

### VS Code
- Theme: QUENCH (monochromatic)
- `~/.vscode/argv.json` → `password-store=basic` (gnome-libsecret unreliable on Wayland)
- `.config/Code/argv.json` is NOT tracked here (use `~/.vscode/argv.json`)

### Scripts (`~/.local/bin/`)
- `clipboard` — cliphist + fzf + wl-copy
- `volume-tui` — curses volume control using wpctl (WM-agnostic)
- `power-profile` — tuned-ppd / power-profiles-daemon cycle via busctl


## How this repo works

- Config files mirror target paths under `~/dotfiles/`
- `install.sh` creates symlinks via `ln -sf`
- `system/` — files that need sudo
- `applications/` — `.desktop` files for TUI apps in Rofi

## Notes

- After theme changes: `pkill dunst && dunst &` to reload dunst
