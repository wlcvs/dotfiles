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
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES/.config/nvim" ~/.config/

# tmux e zsh
ln -sf "$DOTFILES/.tmux.conf" ~/
ln -sf "$DOTFILES/.zshrc"     ~/

echo ""
echo "==> Done! Next steps:"
echo "    1. Restart Sway"
echo "    2. Open Alacritty and run: p10k configure"
echo "    3. Open Neovim — plugins install automatically on first launch"
