#!/usr/bin/env bash
set -e

# Base dotfiles — WM-agnostic
# Install required packages first (see README for your distro), then run this.

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Powerlevel10k..."
if [ ! -d ~/.config/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
else
  echo "   already installed, skipping"
fi

echo "==> Setting zsh as default shell..."
sudo chsh -s "$(command -v zsh)" "$USER"

echo "==> Installing DMZ-White cursor theme..."
curl -fsSL "http://ftp.debian.org/debian/pool/main/d/dmz-cursor-theme/dmz-cursor-theme_0.4.5_all.deb" -o /tmp/dmz.deb
cd /tmp && ar x dmz.deb && tar -xf data.tar.xz
mkdir -p ~/.local/share/icons
cp -r /tmp/usr/share/icons/DMZ-White ~/.local/share/icons/
cd "$DOTFILES"

echo "==> Linking dotfiles..."

mkdir -p ~/.config/alacritty
ln -sf "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/

ln -sf "$DOTFILES/.tmux.conf" ~/
ln -sf "$DOTFILES/.zshrc"     ~/
ln -sf "$DOTFILES/.p10k.zsh"  ~/

mkdir -p ~/.vscode ~/.config/Code/User
cp "$DOTFILES/.vscode-argv.json" ~/.vscode/argv.json
ln -sf "$DOTFILES/.config/Code/User/settings.json" ~/.config/Code/User/settings.json

mkdir -p ~/.local/share/icons/hicolor/512x512/apps
cp "$DOTFILES/icons/code-gray.png" ~/.local/share/icons/hicolor/512x512/apps/vscode.png
gtk-update-icon-cache ~/.local/share/icons/hicolor 2>/dev/null || true

mkdir -p ~/.local/share/applications
cp "$DOTFILES/applications/"*.desktop ~/.local/share/applications/
cp "$DOTFILES/applications/hidden/"*.desktop ~/.local/share/applications/

echo "==> Installing yazi..."
curl -fsSL https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-musl.zip \
  -o /tmp/yazi.zip
unzip -o /tmp/yazi.zip -d /tmp/yazi-extract/
cp /tmp/yazi-extract/yazi-x86_64-unknown-linux-musl/yazi ~/.local/bin/
cp /tmp/yazi-extract/yazi-x86_64-unknown-linux-musl/ya   ~/.local/bin/
chmod +x ~/.local/bin/yazi ~/.local/bin/ya

echo "==> Installing pulsemixer..."
pip3 install pulsemixer --user --break-system-packages 2>/dev/null || \
  pip3 install pulsemixer --user

echo ""
echo "==> Done! Next steps:"
echo "    1. Install Neovim config:  git clone https://github.com/wlcvs/nvim ~/.config/nvim"
echo "    2. Install WM layer:       dotfiles-sway or dotfiles-qtile"
echo "    3. Restart shell (exec zsh) to apply .zshrc"
