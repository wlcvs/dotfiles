#!/usr/bin/env bash
set -e

# Base dotfiles — WM-agnostic
# Target: CachyOS (Arch-based). For Fedora see dotfiles-sway.

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing base packages (pacman)..."
sudo pacman -S --needed \
  alacritty tmux neovim \
  github-cli \
  zsh \
  ttf-jetbrains-mono \
  brightnessctl playerctl \
  wl-clipboard \
  fzf ripgrep fd \
  eza bat jq \
  lazygit \
  git curl wget unzip \
  python-pip \
  xdg-user-dirs

echo "==> Installing AUR packages (yay)..."
yay -S --needed \
  cliphist \
  lazydocker \
  zoxide \
  gum \
  dua-cli \
  fastfetch \
  tldr \
  mpv \
  imagemagick

echo "==> Setting zsh as default shell..."
sudo chsh -s /usr/bin/zsh "$USER"

echo "==> Installing Powerlevel10k..."
if [ ! -d ~/.config/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
else
  echo "   already installed, skipping"
fi

echo "==> Installing DMZ-White cursor theme..."
curl -fsSL "http://ftp.debian.org/debian/pool/main/d/dmz-cursor-theme/dmz-cursor-theme_0.4.5_all.deb" -o /tmp/dmz.deb
cd /tmp && ar x dmz.deb && tar -xf data.tar.xz
mkdir -p ~/.local/share/icons
cp -r /tmp/usr/share/icons/DMZ-White ~/.local/share/icons/
cd "$DOTFILES"

echo "==> Linking dotfiles..."

# Alacritty
mkdir -p ~/.config/alacritty
ln -sf "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/

# tmux, zsh, p10k
ln -sf "$DOTFILES/.tmux.conf" ~/
ln -sf "$DOTFILES/.zshrc"     ~/
ln -sf "$DOTFILES/.p10k.zsh"  ~/

# VS Code
mkdir -p ~/.vscode ~/.config/Code/User
cp "$DOTFILES/.vscode-argv.json" ~/.vscode/argv.json
ln -sf "$DOTFILES/.config/Code/User/settings.json" ~/.config/Code/User/settings.json

# VS Code icon (grayscale override)
mkdir -p ~/.local/share/icons/hicolor/512x512/apps
cp "$DOTFILES/icons/code-gray.png" ~/.local/share/icons/hicolor/512x512/apps/vscode.png
gtk-update-icon-cache ~/.local/share/icons/hicolor 2>/dev/null || true

# Desktop files (TUI apps — picked up by any launcher)
mkdir -p ~/.local/share/applications
cp "$DOTFILES/applications/"*.desktop ~/.local/share/applications/
cp "$DOTFILES/applications/hidden/"*.desktop ~/.local/share/applications/

echo "==> Linking scripts..."
mkdir -p ~/.local/bin
ln -sf "$DOTFILES/.local/bin/clipboard"    ~/.local/bin/clipboard
ln -sf "$DOTFILES/.local/bin/volume-tui"   ~/.local/bin/volume-tui
ln -sf "$DOTFILES/.local/bin/power-profile" ~/.local/bin/power-profile
chmod +x \
  "$DOTFILES/.local/bin/clipboard" \
  "$DOTFILES/.local/bin/volume-tui" \
  "$DOTFILES/.local/bin/power-profile"

echo "==> Installing TUI apps not in pacman..."
# yazi
curl -fsSL https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-musl.zip \
  -o /tmp/yazi.zip
unzip -o /tmp/yazi.zip -d /tmp/yazi-extract/
cp /tmp/yazi-extract/yazi-x86_64-unknown-linux-musl/yazi ~/.local/bin/
cp /tmp/yazi-extract/yazi-x86_64-unknown-linux-musl/ya   ~/.local/bin/
chmod +x ~/.local/bin/yazi ~/.local/bin/ya

# pulsemixer
pip3 install pulsemixer --user --break-system-packages

echo ""
echo "==> Done! Next steps:"
echo "    1. Install WM layer: dotfiles-sway or dotfiles-qtile"
echo "    2. Install Neovim config: git clone https://github.com/wlcvs/nvim ~/.config/nvim"
echo "    3. Open Neovim — plugins install automatically on first launch"
echo "    4. Restart shell (or: exec zsh) to apply .zshrc"
