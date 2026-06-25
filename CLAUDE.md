# CLAUDE.md — dotfiles context

This is wlcsv's personal dotfiles repository for Fedora 44 Sway on a ThinkPad.
The goal is a definitive setup script — never having to reconfigure from scratch again.

## Current machine

- **OS:** Fedora 44 Sway (Wayland)
- **Hardware:** ThinkPad (TPPS/2 Elan TrackPoint + Synaptics touchpad)
- **User:** wlcsv
- **Shell:** zsh with Powerlevel10k (`.p10k.zsh` committed)
- **GitHub account:** wlcvs

## Design system

Monochromatic HUD aesthetic — inspired by the debt-tracker repo design.

**Palette:**
- bg `#0a0a0a` · surface `#111111` · surface2 `#18181b` · border `#27272a`
- text `#e4e4e7` · muted `#a1a1aa` · dim `#71717a` · faint `#52525b` · subtle `#3f3f46`

**Rules:**
- Only black, white and gray — no colors anywhere (not even for status/error states)
- Font: JetBrains Mono everywhere (terminal, Waybar, Rofi, Dunst, Neovim)
- No rounded corners
- No icons or emojis — text labels only (e.g. Waybar shows "BAT 87%" not a battery icon)
- No symbols beyond basic ASCII in prompts/UI

## What's already configured

### Sway (`~/.config/sway/config.d/`)
- `00-input.conf` — keyboard layout `br/thinkpad` (ABNT2), caps↔esc swap, touchpad tap + natural scroll
- `01-terminal.conf` — Alacritty as default terminal, Rofi set to `drun` with theme
- `10-theme.conf` — border colors (monochromatic), 1px border, 6px inner gaps
- `60-bindings-screenshot.conf` — Print=area→clipboard, Alt=window, Ctrl=fullscreen, Shift=save
- `95-gnome-keyring.conf` — starts gnome-keyring-daemon with secrets/ssh components

### Alacritty (`~/.config/alacritty/alacritty.toml`)
- Font: JetBrains Mono 11pt
- Colors: monochromatic zinc (all 16 terminal colors mapped to grayscale)
- Each Alacritty window reuses tmux session "main" via `tmux new-window`
- `Ctrl+Shift+C/V` for copy/paste

### tmux (`~/.tmux.conf`)
- Prefix: `Ctrl+A`
- Mouse on, clipboard via `wl-copy` on drag-select
- Monochromatic status bar (zinc palette)

### zsh (`~/.zshrc`)
- Powerlevel10k (cloned to `~/.config/powerlevel10k`, config at `~/.p10k.zsh`)
- Prompt uses `>` / `<` (ASCII only, no special chars)
- Colors: gray-only palette (no magenta/red/blue/cyan)
- `~/.local/bin` in PATH (lazygit, lazydocker, gum, dua, yazi, bluetuith installed there)
- `eza` replaces `ls` (with icons and git status)
- `bat` replaces `cat` and `less`
- `zoxide` replaces `cd` (via `z` alias)
- `fzf` integrated: `Ctrl+R` for history, `Ctrl+T` for files
- Aliases: `n/vi/vim=nvim`, `lg=lazygit`, `ldk=lazydocker`, `du=dua`, `fetch=fastfetch`, `lt=eza --tree`

### Neovim (`~/.config/nvim/`)
- Plugin manager: lazy.nvim
- Colorscheme: `mono` (custom, at `colors/mono.lua` — zinc palette, bold/italic for syntax, no colors)
- Statusline: lualine with monochromatic theme and no icons (`icons_enabled = false`)
- LSP via Mason (lua, python, ts, rust, go, c, html, css, sql, yaml, json, markdown)
- Formatters: stylua, prettier, shfmt, yamlfmt, taplo
- Key plugins: telescope, harpoon2, nvim-tree, treesitter, nvim-cmp, conform

### Waybar (`~/.config/waybar/`)
- No icons anywhere — all text labels
- Modules: workspaces · window title (center) · VOL % / WIFI % / BAT % / time
- Font: JetBrains Mono 10-11px, letter-spacing 0.05em
- Active workspace: underline (not background highlight)

### Rofi (`~/.config/rofi/theme.rasi`)
- Minimal popup: input bar on top (dark surface), list below
- No icons, no separators beyond borders
- Used with `-theme ~/.config/rofi/theme.rasi` in the Sway binding

### Swaylock (`~/.config/swaylock/config`)
- Solid dark background, gray ring indicator
- No text beyond what swaylock renders internally

### Dunst (`~/.config/dunst/dunstrc`)
- No icons (`icon_position = off`)
- Monochromatic: low=very dim, normal=dim, critical=bright (still gray, just brighter border)
- Top-right corner, 6px gap between notifications, no rounded corners
- Font: JetBrains Mono 10

### GTK (`~/.config/gtk-3.0/` and `~/.config/gtk-4.0/`)
- Dark mode enabled (`gtk-application-prefer-dark-theme=1`)
- Adwaita as base (no custom GTK theme installed — GTK apps are rare)

### Bluetooth
- `bluez` backend, service enabled and running
- `bluetuith` (TUI) as frontend

### Power management (`system/logind-thinkpad.conf`)
- Lid close → suspend (on battery and on AC)
- Power key → suspend
- Idle action → suspend after 30 min
- Applied to `/etc/systemd/logind.conf.d/thinkpad.conf`
- `tuned-ppd` handles power profiles — TLP NOT installed (conflict)

### Docker
- Installed from official Docker repo
- Service enabled and running
- User `wlcsv` added to `docker` group (requires logout to take effect)
- `lazydocker` as TUI frontend

### TUI apps (desktop files in `applications/`, appear in Rofi via Super+D)
- `yazi` — file manager with image preview (binary, GitHub release)
- `pulsemixer` — audio mixer (pip3)
- `bluetuith` — bluetooth manager (binary, GitHub release)
- `btop` — system monitor (dnf)
- `nmtui` — network manager (dnf)
- `lazygit` — git TUI (binary, GitHub release)
- `lazydocker` — Docker TUI (binary, GitHub release)

### CLI tools (Omarchy-inspired, installed via dnf or binary)
- `bat`, `eza`, `fzf`, `zoxide`, `jq`, `gum`, `fastfetch`, `tldr`, `dua`, `mpv`, `imagemagick`

### GUI / Flatpak apps
- Google Chrome (browser)
- Obsidian (Flatpak: md.obsidian.Obsidian)
- Spotify (Flatpak: com.spotify.Client)

### VS Code
- `password-store=basic` in `~/.vscode/argv.json` (saved as `.vscode-argv.json` in repo)

## Removed apps (replaced by TUI or unused)
- `blueman` → bluetuith
- `pavucontrol` → pulsemixer
- `thunar` → yazi
- `firefox` → not needed (Chrome only)
- `foot` → alacritty

## How this repo works

- Config files live in `~/dotfiles/` mirroring the target paths
- `install.sh` creates symlinks with `ln -sf`
- `system/` contains configs that need sudo to install (logind, etc.)
- `applications/` contains `.desktop` files for TUI apps to appear in Rofi
- The Sway config system supports per-user overrides in `~/.config/sway/config.d/`
- Powerlevel10k is cloned (not a submodule) to keep install simple
- Binaries not in Fedora repos go to `~/.local/bin`

## Important notes

- Sway's `$term` variable resolves at parse time — use `unbindsym` + `bindsym` to avoid warnings
- `tuned-ppd` conflicts with TLP — do not install TLP on this system
- `systemctl restart systemd-logind` kills the active session — logind changes only on reboot
- VS Code: `gnome-libsecret` fails in Sway — `basic` store resolved sync error
- Docker group membership requires logout/login to take effect
- Spotify and Obsidian are Flatpak (AUR doesn't exist on Fedora)
- XDG_DATA_DIRS must include `~/.local/share` for Rofi drun to find custom desktop files
- `lazy-lock.json` is excluded via `.config/nvim/.gitignore`
- After theme changes: `swaymsg reload` applies sway config; `pkill waybar` restarts waybar
