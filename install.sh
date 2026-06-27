#!/usr/bin/env bash
# Base dotfiles — install required packages first (see README), then run this.

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Helpers ───────────────────────────────────────────────────────────────────

info()  { echo "==> $*"; }
skip()  { echo "    skipped: $*"; }
warn()  { echo "    warning: $*"; }

aur_helper() {
    command -v paru 2>/dev/null || command -v yay 2>/dev/null || echo ""
}

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

# ── yazi (file manager) ───────────────────────────────────────────────────────

info "Installing yazi..."
if ! command -v yazi &>/dev/null; then
    if command -v pacman &>/dev/null; then
        AUR=$(aur_helper)
        if [ -n "$AUR" ]; then
            "$AUR" -S --needed --noconfirm yazi
        else
            warn "No AUR helper found — install yazi manually or install paru/yay first"
        fi
    else
        ARCH=$(uname -m)
        case "$ARCH" in
            x86_64)  YAZI_ARCH="x86_64-unknown-linux-musl" ;;
            aarch64) YAZI_ARCH="aarch64-unknown-linux-musl" ;;
            *)       warn "Unsupported arch $ARCH for yazi binary download"; YAZI_ARCH="" ;;
        esac
        if [ -n "$YAZI_ARCH" ]; then
            curl -fsSL "https://github.com/sxyazi/yazi/releases/latest/download/yazi-${YAZI_ARCH}.zip" \
                -o /tmp/yazi.zip
            unzip -o /tmp/yazi.zip -d /tmp/yazi-extract/
            mkdir -p ~/.local/bin
            cp /tmp/yazi-extract/yazi-${YAZI_ARCH}/yazi ~/.local/bin/
            cp /tmp/yazi-extract/yazi-${YAZI_ARCH}/ya   ~/.local/bin/
            chmod +x ~/.local/bin/yazi ~/.local/bin/ya
            rm -rf /tmp/yazi.zip /tmp/yazi-extract
        fi
    fi
else
    skip "yazi already installed"
fi

# ── pulsemixer (audio mixer) ──────────────────────────────────────────────────

info "Installing pulsemixer..."
if ! command -v pulsemixer &>/dev/null; then
    if command -v pacman &>/dev/null; then
        sudo pacman -S --needed --noconfirm python-pulsemixer
    elif command -v apt-get &>/dev/null; then
        sudo apt-get install -y python3-pulsemixer 2>/dev/null || \
            pip3 install pulsemixer --user --break-system-packages 2>/dev/null || \
            pip3 install pulsemixer --user
    else
        pip3 install pulsemixer --user --break-system-packages 2>/dev/null || \
            pip3 install pulsemixer --user
    fi
else
    skip "pulsemixer already installed"
fi

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
    if command -v pacman &>/dev/null; then
        AUR=$(aur_helper)
        if [ -n "$AUR" ]; then
            "$AUR" -S --needed google-chrome
        else
            warn "No AUR helper found — install google-chrome from AUR manually"
        fi
    elif command -v apt-get &>/dev/null; then
        curl -fsSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
            -o /tmp/chrome.deb
        sudo apt install -y /tmp/chrome.deb
        rm -f /tmp/chrome.deb
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y \
            https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    else
        warn "Unknown distro — download Chrome from https://google.com/chrome"
    fi
else
    skip "Chrome already installed"
fi

# ── VS Code ───────────────────────────────────────────────────────────────────

info "Installing VS Code..."
if ! command -v code &>/dev/null; then
    if command -v pacman &>/dev/null; then
        AUR=$(aur_helper)
        if [ -n "$AUR" ]; then
            "$AUR" -S --needed --noconfirm visual-studio-code-bin
        else
            warn "No AUR helper found — install visual-studio-code-bin from AUR manually"
        fi
    elif command -v apt-get &>/dev/null; then
        curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
            | sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" \
            | sudo tee /etc/apt/sources.list.d/vscode.list
        sudo apt-get update && sudo apt-get install -y code
    elif command -v dnf &>/dev/null; then
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo dnf install -y \
            https://packages.microsoft.com/yumrepos/vscode/code-latest-x86_64.rpm
    else
        warn "Unknown distro — download VS Code from https://code.visualstudio.com"
    fi
else
    skip "VS Code already installed"
fi

# ── Claude Code ───────────────────────────────────────────────────────────────

info "Installing Claude Code..."
if ! command -v claude &>/dev/null; then
    if command -v npm &>/dev/null; then
        npm install -g @anthropic-ai/claude-code
    else
        warn "npm not found — install Node.js first, then: npm install -g @anthropic-ai/claude-code"
    fi
else
    skip "Claude Code already installed"
fi

echo ""
info "Done! Next steps:"
echo "    1. git clone https://github.com/wlcvs/nvim ~/.config/nvim"
echo "    2. Install WM layer: dotfiles-sway"
echo "    3. exec zsh"
