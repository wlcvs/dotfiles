# CLAUDE.md — dotfiles context

This is wlcsv's personal dotfiles repository for Fedora 44 Sway on a ThinkPad.
The goal is a definitive setup script — never having to reconfigure from scratch again.

## Current machine

- **OS:** Fedora 44 Sway (Wayland)
- **Hardware:** ThinkPad (TPPS/2 Elan TrackPoint + Synaptics touchpad)
- **User:** wlcsv
- **Shell:** zsh with Powerlevel10k (`.p10k.zsh` committed)
- **GitHub account:** wlcvs

## What's already configured

### Sway (`~/.config/sway/config.d/`)
- `00-input.conf` — keyboard layout `br/thinkpad` (ABNT2), caps↔esc swap, touchpad tap + natural scroll
- `01-terminal.conf` — Alacritty as default terminal (`unbindsym` + rebind to avoid warning), Rofi set to `drun` only (no PATH executables)
- `60-bindings-screenshot.conf` — Print=area→clipboard, Alt=window, Ctrl=fullscreen, Shift=save to file
- `95-gnome-keyring.conf` — starts gnome-keyring-daemon with secrets/ssh components

### Alacritty (`~/.config/alacritty/alacritty.toml`)
- Font: MesloLGS NF 11pt
- Theme: Catppuccin Mocha
- Auto-starts tmux session "main" on open
- `Ctrl+Shift+C/V` for copy/paste

### tmux (`~/.tmux.conf`)
- Prefix: `Ctrl+A`
- Mouse on, clipboard via `wl-copy` on drag-select
- Catppuccin Mocha status bar

### zsh (`~/.zshrc`)
- Powerlevel10k (cloned to `~/.config/powerlevel10k`, config at `~/.p10k.zsh`)
- Fonts: MesloLGS NF at `~/.local/share/fonts/MesloLGS/`
- Aliases: `n=nvim`, `vi=nvim`, `vim=nvim`
- `~/.local/bin` in PATH (yazi, bluetuith, pulsemixer installed there)

### Neovim (`~/.config/nvim/`)
- Plugin manager: lazy.nvim
- LSP via Mason (lua, python, ts, rust, go, c, html, css, sql, yaml, json, markdown)
- Formatters: stylua, prettier, shfmt, yamlfmt, taplo
- Key plugins: telescope, harpoon2, nvim-tree, treesitter, nvim-cmp, conform
- Theme: tokyonight

### GTK (`~/.config/gtk-3.0/` and `~/.config/gtk-4.0/`)
- Dark mode enabled (`gtk-application-prefer-dark-theme=1`)
- Using Adwaita-dark as placeholder — **full custom theme is planned later**

### Bluetooth
- `bluez` backend, service enabled and running
- GUI (blueman) removed — replaced by `bluetuith` (TUI)
- gnome-keyring started via `95-gnome-keyring.conf` (useful for SSH agent too)

### Power management (`system/logind-thinkpad.conf`)
- Lid close → suspend (on battery and on AC)
- Power key → suspend
- Idle action → suspend after 30 min
- Applied to `/etc/systemd/logind.conf.d/thinkpad.conf`
- `tuned-ppd` (pre-installed by Fedora) handles power profiles — TLP NOT installed (conflict)

### TUI apps (desktop files in `applications/`, appear in Rofi)
- `yazi` — file manager (binary at `~/.local/bin`, installed from GitHub release)
- `pulsemixer` — audio mixer (installed via pip3)
- `bluetuith` — bluetooth manager (binary at `~/.local/bin`, installed from GitHub release)
- `btop` — system monitor (dnf)
- `nmtui` — network manager (dnf, part of NetworkManager-tui)

### VS Code
- `password-store=basic` in `~/.vscode/argv.json` (saved as `.vscode-argv.json` in repo)

## Removed apps (replaced by TUI)
- `blueman` → bluetuith
- `pavucontrol` → pulsemixer
- `thunar` / `thunar-archive-plugin` → yazi
- `firefox` → not needed (Chrome only)
- `foot` → alacritty

## What still needs to be done

The user wants a **complete custom theme** covering everything — planned as the final task:
- [ ] Custom Waybar config + theme
- [ ] Custom Rofi theme
- [ ] Custom Swaylock theme
- [ ] Custom Dunst theme
- [ ] GTK theme (replace Adwaita-dark placeholder)
- [ ] Icon theme
- [ ] Cursor theme
- [ ] Night light / screen temperature (wlsunset or gammastep)

## How this repo works

- Config files live in `~/dotfiles/` mirroring the target paths
- `install.sh` creates symlinks with `ln -sf`
- `system/` contains configs that need sudo to install (logind, etc.)
- `applications/` contains `.desktop` files for TUI apps to appear in Rofi
- The Sway config system supports per-user overrides in `~/.config/sway/config.d/` — we only add files there, never touching `/etc/sway/`
- Powerlevel10k is cloned (not a submodule) to keep install simple
- yazi and bluetuith are installed as binaries to `~/.local/bin` (not in Fedora repos)

## Important notes

- The nvim repo (`wlcvs/nvim`) was merged into this repo and deleted
- `lazy-lock.json` is excluded via `.config/nvim/.gitignore`
- Sway's `$term` variable resolves at parse time — use `unbindsym` + `bindsym` to override keybindings from system config without warnings
- `tuned-ppd` conflicts with TLP — do not install TLP on this system
- `systemctl restart systemd-logind` kills the active session — never run while logged in; logind changes only take effect on reboot
- VS Code: `gnome-libsecret` was attempted but `GNOME_KEYRING_CONTROL` isn't exported in Sway session — `basic` store resolved the sync error
