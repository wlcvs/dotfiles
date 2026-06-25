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
- wallpaper `#3f3f3f`

**Rules — non-negotiable:**
- Only black, white and gray — no colors anywhere (not even for status/error states)
- Font: JetBrains Mono everywhere (terminal, Waybar, Rofi, Dunst, Neovim, VS Code)
- No rounded corners anywhere
- No icons or emojis — text labels only (e.g. Waybar shows "BAT 87%" not a battery icon)
- No symbols beyond basic ASCII in prompts/UI

## What's configured

### Login manager (greetd + tuigreet)
- `system/greetd-config.toml` → `/etc/greetd/config.toml`
- Terminal login on TTY1, lists Wayland sessions from `/usr/share/wayland-sessions`
- Requires a dedicated `greeter` user: `useradd -M -G video greeter`
- `greetd.service` must be enabled; `sddm` disabled

### Sway (`~/.config/sway/config.d/`)
- `00-input.conf` — keyboard layout `br/thinkpad` (ABNT2), caps↔esc swap, touchpad tap + natural scroll
- `01-terminal.conf` — Alacritty as default terminal, Rofi set to `drun` with theme
- `10-theme.conf` — wallpaper `#3f3f3f` solid, border colors (monochromatic), 1px border, 6px inner gaps
- `60-bindings-screenshot.conf` — Print=area→clipboard, Alt=window, Ctrl=fullscreen, Shift=save
- `95-gnome-keyring.conf` — starts gnome-keyring-daemon with secrets/ssh components

### Sway environment (`~/.config/sway/environment`)
- `NO_COLOR=1` — suppresses ANSI colors in CLIs that respect the standard
- `XDG_DATA_DIRS` includes `~/.local/share` so Rofi finds custom desktop files

### Alacritty (`~/.config/alacritty/alacritty.toml`)
- Font: JetBrains Mono 11pt
- Colors: all 16 terminal ANSI colors remapped to grayscale (zinc palette)
- Each Alacritty window reuses tmux session "main" via `tmux new-window`

### tmux (`~/.tmux.conf`)
- Prefix: `Ctrl+A`
- Mouse on, clipboard via `wl-copy`
- Monochromatic status bar: session name left, date/time right, zinc palette

### zsh (`~/.zshrc`)
- Powerlevel10k (cloned to `~/.config/powerlevel10k`)
- Prompt: `>` and `<` (ASCII only), gray-only colors
- `~/.local/bin` in PATH
- eza, bat, zoxide, fzf integrations

### Neovim (`~/.config/nvim/`)
- Plugin manager: lazy.nvim
- Colorscheme: `mono` (custom local, at `colors/mono.lua` — zinc grays, bold/italic for syntax)
- Statusline: lualine with monochromatic theme, `icons_enabled = false`
- LSP via Mason, formatters via conform, telescope, harpoon2, treesitter, nvim-cmp

### Waybar (`~/.config/waybar/`)
- No icons — text labels only
- Right modules: `CPU %  MEM G  TEMP C | BRT %  VOL %  WIFI % | BAT % | HH:MM  DD/MM`
- Separators via `border-left` between groups
- Scroll on VOL and BRT adjusts volume/brightness
- Temperature: `thermal-zone 6` (x86_pkg_temp, the actual CPU package sensor)
- Font: JetBrains Mono 10px

### Rofi (`~/.config/rofi/theme.rasi`)
- Minimal popup with zinc colors, no icons
- Used with `-theme ~/.config/rofi/theme.rasi`

### Power menu — wlogout (`~/.config/wlogout/`)
- `Super+Shift+E` opens wlogout (overrides default swaynag exit dialog), defined in `90-power-menu.conf`
- 5 buttons in a row: Lock, Logout, Suspend, Reboot, Shutdown — text-only, no icons
- CSS: zinc palette, JetBrains Mono, no border-radius
- Keybinds: `l` lock, `e` logout, `u` suspend, `r` reboot, `s` shutdown

### Swaynag (`~/.config/swaynag/config`)
- Exit/error dialogs: surface `#111111` bg, zinc border, no yellow — matches monochromatic theme
- Still used internally by Sway for confirmations other than the exit dialog

### Swaylock (`~/.config/swaylock/config`)
- Solid `#0a0a0a` background, gray ring indicator, no icons

### Dunst (`~/.config/dunst/dunstrc`)
- No icons (`icon_position = off`), monochromatic urgency levels
- New syntax: `height = (0, 100)`, `offset = (12, 12)` (dunst 1.12+)
- Top-right, 6px gap, no rounded corners

### GTK
- Dark mode: `gtk-application-prefer-dark-theme=1`

### VS Code
- Theme: GitHub Dark Dimmed + full zinc palette override via `workbench.colorCustomizations`
- Syntax: monochrome via `editor.tokenColorCustomizations` (bold/italic for differentiation)
- Font: JetBrains Mono 13px, ligatures on
- Icon theme disabled (`null`)
- `password-store=basic` in `~/.vscode/argv.json`

### Bluetooth
- `bluez` backend, service enabled
- `bluetuith` (TUI) as frontend

### Power management (`system/logind-thinkpad.conf`)
- Lid close → suspend, Power key → suspend, Idle → suspend after 30min
- `tuned-ppd` handles power profiles — **TLP NOT installed (conflict)**

### Docker
- `docker-ce` from official repo, service enabled
- User in `docker` group (requires logout to take effect)
- `lazydocker` as TUI frontend

### TUI apps (Rofi via Super+D)
- yazi, pulsemixer, bluetuith, btop, nmtui, lazygit, lazydocker

### CLI tools
- bat, eza, fzf, zoxide, jq, gum, fastfetch, tldr, dua, mpv, imagemagick

### GUI / Flatpak
- Google Chrome, Obsidian (Flatpak), Spotify (Flatpak)

## How this repo works

- Config files live in `~/dotfiles/` mirroring target paths
- `install.sh` creates symlinks with `ln -sf`
- `system/` — configs that need sudo (logind)
- `applications/` — `.desktop` files for TUI apps
- Sway config system: user overrides in `~/.config/sway/config.d/`
- Binaries not in Fedora repos go to `~/.local/bin`

## Important notes

- Sway's `$term` resolves at parse time — use `unbindsym` + `bindsym` to avoid warnings
- **`systemctl restart systemd-logind` kills the active session** — logind changes only on reboot
- TLP conflicts with tuned-ppd — do NOT install TLP
- VS Code: `gnome-libsecret` fails in Sway — `basic` store resolved sync
- Docker group membership requires logout/login
- Spotify and Obsidian are Flatpak only (no Fedora package)
- XDG_DATA_DIRS must include `~/.local/share` for Rofi to find custom desktop files
- `lazy-lock.json` excluded via `.config/nvim/.gitignore`
- After theme changes: `swaymsg reload` applies sway+waybar; `pkill dunst && dunst &` for dunst
- Do NOT manually start waybar — Sway starts it automatically on reload
