#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Instalando pacotes..."
sudo dnf install -y \
  alacritty tmux neovim \
  gh \
  grim slurp grimshot \
  swaylock swayidle \
  waybar rofi \
  foot \
  wl-clipboard \
  dunst

echo "==> Definindo zsh como shell padrão..."
sudo chsh -s /usr/bin/zsh "$USER"

echo "==> Instalando fontes MesloLGS NF..."
mkdir -p ~/.local/share/fonts/MesloLGS
BASE="https://github.com/romkatv/powerlevel10k-media/raw/master"
for font in "MesloLGS NF Regular.ttf" "MesloLGS NF Bold.ttf" "MesloLGS NF Italic.ttf" "MesloLGS NF Bold Italic.ttf"; do
  curl -fsSL "$BASE/${font// /%20}" -o ~/.local/share/fonts/MesloLGS/"$font"
done
fc-cache -f ~/.local/share/fonts/

echo "==> Instalando Powerlevel10k..."
if [ ! -d ~/.config/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
else
  echo "   já instalado, pulando"
fi

echo "==> Linkando dotfiles..."
# Sway
mkdir -p ~/.config/sway/config.d
ln -sf "$DOTFILES/.config/sway/config.d/00-input.conf"              ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/01-terminal.conf"           ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/60-bindings-screenshot.conf" ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/environment"                          ~/.config/sway/

# Alacritty
mkdir -p ~/.config/alacritty
ln -sf "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/

# tmux e zsh
ln -sf "$DOTFILES/.tmux.conf" ~/
ln -sf "$DOTFILES/.zshrc"     ~/

echo ""
echo "==> Pronto! Reinicie o Sway e depois rode 'p10k configure' para personalizar o prompt."
