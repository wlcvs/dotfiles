#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing packages..."
sudo dnf install -y \
  alacritty tmux neovim \
  gh \
  grim slurp grimshot \
  swaylock swayidle \
  waybar rofi \
  wl-clipboard \
  dunst \
  bluez blueman \
  fd-find ripgrep gcc \
  git curl

echo "==> Setting zsh as default shell..."
sudo chsh -s /usr/bin/zsh "$USER"

echo "==> Installing MesloLGS NF fonts..."
mkdir -p ~/.local/share/fonts/MesloLGS
BASE="https://github.com/romkatv/powerlevel10k-media/raw/master"
for font in "MesloLGS NF Regular.ttf" "MesloLGS NF Bold.ttf" "MesloLGS NF Italic.ttf" "MesloLGS NF Bold Italic.ttf"; do
  curl -fsSL "$BASE/${font// /%20}" -o ~/.local/share/fonts/MesloLGS/"$font"
done
fc-cache -f ~/.local/share/fonts/

echo "==> Installing Powerlevel10k..."
if [ ! -d ~/.config/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
else
  echo "   already installed, skipping"
fi

echo "==> Enabling services..."
sudo systemctl enable --now bluetooth

echo "==> Applying system config (logind — ThinkPad power management)..."
# NOTE: does NOT restart logind (would kill the session). Takes effect on next boot.
sudo mkdir -p /etc/systemd/logind.conf.d
sudo cp "$DOTFILES/system/logind-thinkpad.conf" /etc/systemd/logind.conf.d/thinkpad.conf

echo "==> Linking dotfiles..."

# Sway
mkdir -p ~/.config/sway/config.d
ln -sf "$DOTFILES/.config/sway/config.d/00-input.conf"               ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/01-terminal.conf"            ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/60-bindings-screenshot.conf" ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/environment"                          ~/.config/sway/

# Alacritty
mkdir -p ~/.config/alacritty
ln -sf "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/

# Neovim
ln -sf "$DOTFILES/.config/nvim" ~/.config/

# GTK dark mode
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
ln -sf "$DOTFILES/.config/gtk-3.0/settings.ini" ~/.config/gtk-3.0/
ln -sf "$DOTFILES/.config/gtk-4.0/settings.ini" ~/.config/gtk-4.0/

# tmux, zsh e p10k
ln -sf "$DOTFILES/.tmux.conf"  ~/
ln -sf "$DOTFILES/.zshrc"      ~/
ln -sf "$DOTFILES/.p10k.zsh"   ~/

echo ""
echo "==> Done! Next steps:"
echo "    1. Reboot (applies logind power config)"
echo "    2. Open Neovim — plugins install automatically on first launch"
