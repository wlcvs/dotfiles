#!/usr/bin/env bash
set -e

# Base dotfiles — install required packages first (see README), then run this.

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Shell ─────────────────────────────────────────────────────────────────────

echo "==> Setting zsh as default shell..."
sudo chsh -s "$(command -v zsh)" "$USER"

echo "==> Installing Powerlevel10k..."
if [ ! -d ~/.config/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
else
  echo "   already installed, skipping"
fi

# ── Cursor theme ──────────────────────────────────────────────────────────────

echo "==> Installing DMZ-White cursor theme..."
curl -fsSL "http://ftp.debian.org/debian/pool/main/d/dmz-cursor-theme/dmz-cursor-theme_0.4.5_all.deb" \
  -o /tmp/dmz.deb
cd /tmp && ar x dmz.deb && tar -xf data.tar.xz
mkdir -p ~/.local/share/icons
cp -r /tmp/usr/share/icons/DMZ-White ~/.local/share/icons/
cd "$DOTFILES"

# ── Dotfile symlinks ──────────────────────────────────────────────────────────

echo "==> Linking dotfiles..."
mkdir -p ~/.config/alacritty
ln -sf "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/

ln -sf "$DOTFILES/.tmux.conf" ~/
ln -sf "$DOTFILES/.zshrc"     ~/
ln -sf "$DOTFILES/.p10k.zsh"  ~/

# ── TUI tools (not in standard repos) ────────────────────────────────────────

echo "==> Installing yazi (file manager)..."
curl -fsSL https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-musl.zip \
  -o /tmp/yazi.zip
unzip -o /tmp/yazi.zip -d /tmp/yazi-extract/
mkdir -p ~/.local/bin
cp /tmp/yazi-extract/yazi-x86_64-unknown-linux-musl/yazi ~/.local/bin/
cp /tmp/yazi-extract/yazi-x86_64-unknown-linux-musl/ya   ~/.local/bin/
chmod +x ~/.local/bin/yazi ~/.local/bin/ya

echo "==> Installing pulsemixer (audio)..."
pip3 install pulsemixer --user --break-system-packages 2>/dev/null || \
  pip3 install pulsemixer --user

# ── Apps (Flatpak) ────────────────────────────────────────────────────────────

echo "==> Installing Flatpak apps..."
if command -v flatpak &>/dev/null; then
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  flatpak install -y flathub com.spotify.Client
  flatpak install -y flathub md.obsidian.Obsidian
else
  echo "   flatpak not found — install it first, then run:"
  echo "   flatpak install flathub com.spotify.Client md.obsidian.Obsidian"
fi

# ── Google Chrome ─────────────────────────────────────────────────────────────

echo "==> Installing Google Chrome..."
if command -v pacman &>/dev/null; then
  yay -S --needed google-chrome
elif command -v apt-get &>/dev/null; then
  curl -fsSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    -o /tmp/chrome.deb
  sudo apt install -y /tmp/chrome.deb
elif command -v dnf &>/dev/null; then
  sudo dnf install -y \
    https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
else
  echo "   Unknown distro — download Chrome from https://google.com/chrome"
fi

# ── Claude Code ───────────────────────────────────────────────────────────────

echo "==> Installing Claude Code..."
if command -v npm &>/dev/null; then
  npm install -g @anthropic-ai/claude-code
else
  echo "   npm not found — install Node.js first (see README), then:"
  echo "   npm install -g @anthropic-ai/claude-code"
fi

echo ""
echo "==> Done! Next steps:"
echo "    1. git clone https://github.com/wlcvs/nvim ~/.config/nvim  (Neovim)"
echo "    2. Install WM layer: dotfiles-sway or dotfiles-qtile"
echo "    3. exec zsh  (reload shell)"
