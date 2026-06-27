#!/usr/bin/env bash
# Base dotfiles — Arch Linux

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Helpers ───────────────────────────────────────────────────────────────────

info()  { echo "==> $*"; }
skip()  { echo "    skipped: $*"; }
warn()  { echo "    warning: $*"; }

aur_helper() {
    command -v paru 2>/dev/null || command -v yay 2>/dev/null || echo ""
}

# ── Packages (pacman) ─────────────────────────────────────────────────────────

info "Installing pacman packages..."
sudo pacman -S --needed --noconfirm \
    alacritty tmux zsh git curl unzip \
    ttf-jetbrains-mono \
    nodejs npm \
    flatpak \
    fzf ripgrep fd bat jq python-pip \
    lazygit eza zoxide btop mpv imagemagick \
    python-pulsemixer github-cli

# ── Packages (AUR) ────────────────────────────────────────────────────────────

info "Installing AUR packages..."
AUR=$(aur_helper)
if [ -n "$AUR" ]; then
    "$AUR" -S --needed --noconfirm \
        yazi lazydocker gum dua-cli fastfetch tldr bluetuith
else
    warn "No AUR helper found (paru/yay) — install one first, then re-run"
fi

# ── Shell ─────────────────────────────────────────────────────────────────────

info "Setting zsh as default shell..."
if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$(command -v zsh)" ]; then
    sudo chsh -s "$(command -v zsh)" "$USER"
else
    skip "zsh already the login shell"
fi

info "Installing Powerlevel10k..."
if [ ! -d ~/.config/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
else
    skip "already cloned"
fi

# ── Dotfile symlinks ──────────────────────────────────────────────────────────

info "Linking dotfiles..."
mkdir -p ~/.config/alacritty
ln -sf "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/

ln -sf "$DOTFILES/.tmux.conf" ~/
ln -sf "$DOTFILES/.zshrc"     ~/
ln -sf "$DOTFILES/.p10k.zsh"  ~/

# ── Flatpak apps ──────────────────────────────────────────────────────────────

info "Installing Flatpak apps..."
if command -v flatpak &>/dev/null; then
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install -y --noninteractive flathub com.spotify.Client  2>/dev/null || warn "Spotify install failed"
    flatpak install -y --noninteractive flathub md.obsidian.Obsidian 2>/dev/null || warn "Obsidian install failed"
else
    warn "flatpak not found — install it first, then run:"
    echo "  flatpak install flathub com.spotify.Client md.obsidian.Obsidian"
fi

# ── Google Chrome ─────────────────────────────────────────────────────────────

info "Installing Google Chrome..."
if ! command -v google-chrome-stable &>/dev/null && ! command -v google-chrome &>/dev/null; then
    AUR=$(aur_helper)
    if [ -n "$AUR" ]; then
        "$AUR" -S --needed --noconfirm google-chrome
    else
        warn "No AUR helper found — install google-chrome from AUR manually"
    fi
else
    skip "Chrome already installed"
fi

# ── VS Code ───────────────────────────────────────────────────────────────────

info "Installing VS Code..."
if ! command -v code &>/dev/null; then
    AUR=$(aur_helper)
    if [ -n "$AUR" ]; then
        "$AUR" -S --needed --noconfirm visual-studio-code-bin
    else
        warn "No AUR helper found — install visual-studio-code-bin from AUR manually"
    fi
else
    skip "VS Code already installed"
fi

# ── Claude Code ───────────────────────────────────────────────────────────────

info "Installing Claude Code..."
if ! command -v claude &>/dev/null; then
    curl -fsSL https://claude.ai/install.sh | sh
else
    skip "Claude Code already installed"
fi

echo ""
info "Done! exec zsh to start."
