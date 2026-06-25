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
- `60-bindings-screenshot.conf` — grimshot with dunst notifications

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

### Neovim (`~/.config/nvim/`)
- Plugin manager: lazy.nvim
- LSP via Mason (lua, python, ts, rust, go, c, html, css, sql, yaml, json, markdown)
- Formatters: stylua, prettier, shfmt, yamlfmt, taplo
- Key plugins: telescope, harpoon2, nvim-tree, treesitter, nvim-cmp, conform
- Theme: tokyonight

### GTK (`~/.config/gtk-3.0/` and `~/.config/gtk-4.0/`)
- Dark mode enabled (`gtk-application-prefer-dark-theme=1`)
- Using Adwaita-dark as placeholder — **full custom theme is planned later**
- gsettings: `color-scheme=prefer-dark`, `gtk-theme=Adwaita-dark`

### Bluetooth
- `bluez` + `blueman` installed, service enabled
- `blueman-applet` starts automatically via XDG autostart

### Power management (`system/logind-thinkpad.conf`)
- Lid close → suspend (on battery and on AC)
- Power key → suspend
- Idle action → suspend after 30 min
- Applied to `/etc/systemd/logind.conf.d/thinkpad.conf`
- **WARNING:** never run `systemctl restart systemd-logind` in an active session — it kills the session. Changes take effect on next reboot.
- `tuned-ppd` (pre-installed by Fedora) handles power profiles — TLP is NOT used due to conflict

## What still needs to be done

The user wants a **complete custom theme** covering everything — this is planned as the last big task:
- [ ] Custom Waybar config + theme
- [ ] Custom Rofi theme
- [ ] Custom Swaylock theme
- [ ] Custom Dunst theme
- [ ] GTK theme (replace Adwaita-dark placeholder)
- [ ] Icon theme
- [ ] Cursor theme
- [ ] Swayidle customization
- [ ] Night light / screen temperature (wlsunset or gammastep)
- [ ] Any browser config

## How this repo works

- Config files live in `~/dotfiles/` mirroring the target paths
- `install.sh` creates symlinks with `ln -sf`
- `system/` contains configs that need sudo to install (logind, etc.)
- The Sway config system supports per-user overrides in `~/.config/sway/config.d/` — we only add files there, never touching `/etc/sway/`
- Powerlevel10k is cloned (not a submodule) to keep install simple

## Important notes

- The nvim repo (`wlcvs/nvim`) was merged into this repo and deleted
- `lazy-lock.json` is excluded via `.config/nvim/.gitignore`
- Sway's `$term` variable resolves at parse time — use `unbindsym` + `bindsym` to override keybindings from system config without warnings
- `tuned-ppd` conflicts with TLP — do not install TLP on this system
