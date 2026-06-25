# CLAUDE.md — dotfiles context

This is wlcsv's personal dotfiles repository for Fedora 44 Sway on a ThinkPad.
The goal is a definitive setup script — never having to reconfigure from scratch again.

## Current machine

- **OS:** Fedora 44 Sway (Wayland)
- **Hardware:** ThinkPad (TPPS/2 Elan TrackPoint + Synaptics touchpad)
- **User:** wlcsv
- **Shell:** zsh (default), bash available
- **GitHub account:** wlcvs

## What's already configured

### Sway (`~/.config/sway/config.d/`)
- `00-input.conf` — keyboard layout `br/thinkpad` (ABNT2), caps↔esc swap, touchpad tap + natural scroll
- `01-terminal.conf` — sets Alacritty as default terminal, overrides `Super+Enter`
- `60-bindings-screenshot.conf` — grimshot with dunst notifications

### Alacritty (`~/.config/alacritty/alacritty.toml`)
- Font: MesloLGS NF 11pt
- Theme: Catppuccin Mocha
- Auto-starts tmux session "main" on open
- `Ctrl+Shift+C/V` for copy/paste

### tmux (`~/.tmux.conf`)
- Prefix: `Ctrl+A`
- Mouse on, clipboard via `wl-copy` on drag
- Catppuccin Mocha status bar

### zsh (`~/.zshrc`)
- Powerlevel10k theme (cloned to `~/.config/powerlevel10k`)
- Fonts: MesloLGS NF at `~/.local/share/fonts/MesloLGS/`
- `vi`/`vim` aliased to `nvim`

### Neovim (`~/.config/nvim/`)
- Plugin manager: lazy.nvim
- LSP via Mason (lua, python, ts, rust, go, c, html, css, sql, yaml, json, markdown)
- Formatters: stylua, prettier, shfmt, yamlfmt, taplo
- Key plugins: telescope, harpoon2, nvim-tree, treesitter, nvim-cmp, conform
- Theme: tokyonight

## What still needs to be done

The user wants this to be a complete, definitive setup. Areas not yet covered:

- [ ] GTK/Qt theme configuration (apps look unstyled inside Sway)
- [ ] Bluetooth setup (no GUI configured)
- [ ] Waybar customization (using Fedora defaults)
- [ ] Rofi theme/styling
- [ ] Swaylock customization
- [ ] Dunst styling
- [ ] `~/.p10k.zsh` — after user runs `p10k configure`, commit the result here
- [ ] Power management / battery (ThinkPad)
- [ ] Fonts beyond MesloLGS (system UI fonts)
- [ ] Night light / screen temperature (wlsunset or gammastep)
- [ ] File manager (Thunar installed, not themed)
- [ ] Any browser config / extensions

## How this repo works

- Config files live in `~/dotfiles/` mirroring the target paths
- `install.sh` creates symlinks with `ln -sf`
- The Sway config system supports per-user overrides in `~/.config/sway/config.d/` — we only add files there, never touching `/etc/sway/`
- Powerlevel10k is cloned (not a submodule) to keep install simple

## Important notes

- The nvim repo (`wlcvs/nvim`) was merged into this repo and deleted
- `lazy-lock.json` is intentionally excluded (regenerates on first launch)
- When the user runs `p10k configure`, add the resulting `~/.p10k.zsh` to this repo
- Sway's `$term` variable resolves at parse time, so we override the keybinding directly in `01-terminal.conf` rather than just setting the variable
