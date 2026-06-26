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
  bluez \
  greetd tuigreet \
  fd-find ripgrep gcc \
  jetbrains-mono-fonts \
  git curl \
  brightnessctl playerctl wlsunset \
  cliphist fzf \
  gnome-themes-extra

echo "==> Setting zsh as default shell..."
sudo chsh -s /usr/bin/zsh "$USER"

echo "==> Installing Powerlevel10k..."
if [ ! -d ~/.config/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
else
  echo "   already installed, skipping"
fi

echo "==> Enabling services..."
sudo systemctl enable --now bluetooth

echo "==> Configuring greetd (replaces SDDM)..."
sudo cp "$DOTFILES/system/greetd-config.toml" /etc/greetd/config.toml
id greeter &>/dev/null || sudo useradd -M -G video greeter
sudo systemctl disable sddm 2>/dev/null || true
sudo systemctl enable greetd

echo "==> Applying system config (logind — ThinkPad power management)..."
# NOTE: does NOT restart logind (would kill the session). Takes effect on next boot.
sudo mkdir -p /etc/systemd/logind.conf.d
sudo cp "$DOTFILES/system/logind-thinkpad.conf" /etc/systemd/logind.conf.d/thinkpad.conf

echo "==> Installing DMZ-White cursor theme..."
curl -fsSL "http://ftp.debian.org/debian/pool/main/d/dmz-cursor-theme/dmz-cursor-theme_0.4.5_all.deb" -o /tmp/dmz.deb
cd /tmp && ar x dmz.deb && tar -xf data.tar.xz
mkdir -p ~/.local/share/icons
cp -r /tmp/usr/share/icons/DMZ-White ~/.local/share/icons/
cd "$DOTFILES"

echo "==> Linking dotfiles..."

# Sway
mkdir -p ~/.config/sway/config.d
ln -sf "$DOTFILES/.config/sway/config.d/00-input.conf"               ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/01-terminal.conf"            ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/10-theme.conf"               ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/20-bindings-extra.conf"      ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/60-bindings-screenshot.conf" ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/90-power-menu.conf"          ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/90-swayidle.conf"            ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/95-gnome-keyring.conf"       ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/98-autostart.conf"           ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/environment"                          ~/.config/sway/

# Alacritty
mkdir -p ~/.config/alacritty
ln -sf "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/

# Waybar
mkdir -p ~/.config/waybar
ln -sf "$DOTFILES/.config/waybar/config.jsonc" ~/.config/waybar/
ln -sf "$DOTFILES/.config/waybar/style.css"    ~/.config/waybar/

# Rofi
mkdir -p ~/.config/rofi
ln -sf "$DOTFILES/.config/rofi/config.rasi" ~/.config/rofi/
ln -sf "$DOTFILES/.config/rofi/theme.rasi"  ~/.config/rofi/

# Swaynag
mkdir -p ~/.config/swaynag
ln -sf "$DOTFILES/.config/swaynag/config" ~/.config/swaynag/

# Swaylock
mkdir -p ~/.config/swaylock
ln -sf "$DOTFILES/.config/swaylock/config" ~/.config/swaylock/

# Dunst
mkdir -p ~/.config/dunst
ln -sf "$DOTFILES/.config/dunst/dunstrc" ~/.config/dunst/

# Neovim
ln -sf "$DOTFILES/.config/nvim" ~/.config/

# GTK dark mode
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
ln -sf "$DOTFILES/.config/gtk-3.0/settings.ini" ~/.config/gtk-3.0/
ln -sf "$DOTFILES/.config/gtk-4.0/settings.ini" ~/.config/gtk-4.0/
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# tmux, zsh e p10k
ln -sf "$DOTFILES/.tmux.conf"  ~/
ln -sf "$DOTFILES/.zshrc"      ~/
ln -sf "$DOTFILES/.p10k.zsh"   ~/

# TUI apps desktop files em /usr/local/share (já está no XDG_DATA_DIRS por padrão)
sudo cp "$DOTFILES/applications/"*.desktop /usr/local/share/applications/
sudo update-desktop-database /usr/local/share/applications/

# Esconde apps indesejados do Rofi
mkdir -p ~/.local/share/applications
cp "$DOTFILES/applications/hidden/"*.desktop ~/.local/share/applications/
update-desktop-database ~/.local/share/applications/

# VS Code
mkdir -p ~/.vscode ~/.config/Code/User
cp "$DOTFILES/.vscode-argv.json" ~/.vscode/argv.json
ln -sf "$DOTFILES/.config/Code/User/settings.json" ~/.config/Code/User/settings.json

# VS Code icon (grayscale override)
mkdir -p ~/.local/share/icons/hicolor/512x512/apps
cp "$DOTFILES/icons/code-gray.png" ~/.local/share/icons/hicolor/512x512/apps/vscode.png
gtk-update-icon-cache ~/.local/share/icons/hicolor 2>/dev/null || true

echo "==> Linking scripts..."
mkdir -p ~/.local/bin
ln -sf "$DOTFILES/.local/bin/clipboard"              ~/.local/bin/clipboard
ln -sf "$DOTFILES/.local/bin/first-empty-workspace"  ~/.local/bin/first-empty-workspace
ln -sf "$DOTFILES/.local/bin/power-profile"          ~/.local/bin/power-profile
ln -sf "$DOTFILES/.local/bin/volume-popup"           ~/.local/bin/volume-popup
ln -sf "$DOTFILES/.local/bin/wifi-popup"             ~/.local/bin/wifi-popup
chmod +x "$DOTFILES/.local/bin/clipboard" "$DOTFILES/.local/bin/first-empty-workspace" "$DOTFILES/.local/bin/power-profile" "$DOTFILES/.local/bin/volume-popup" "$DOTFILES/.local/bin/wifi-popup"

echo ""
echo "==> Installing TUI apps not in dnf..."
# yazi
curl -fsSL https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-musl.zip -o /tmp/yazi.zip
unzip -o /tmp/yazi.zip -d /tmp/yazi-extract/
cp /tmp/yazi-extract/yazi-x86_64-unknown-linux-musl/yazi ~/.local/bin/
cp /tmp/yazi-extract/yazi-x86_64-unknown-linux-musl/ya ~/.local/bin/
chmod +x ~/.local/bin/yazi ~/.local/bin/ya

# bluetuith
BT_URL=$(curl -fsSL https://api.github.com/repos/bluetuith-org/bluetuith/releases/latest | python3 -c "import json,sys; r=json.load(sys.stdin); [print(a['browser_download_url']) for a in r['assets'] if 'Linux' in a['name'] and 'x86_64' in a['name']]" | head -1)
curl -fsSL "$BT_URL" -o /tmp/bluetuith.tar.gz
tar -xzf /tmp/bluetuith.tar.gz -C /tmp/
cp /tmp/bluetuith ~/.local/bin/ && chmod +x ~/.local/bin/bluetuith

# pulsemixer
pip3 install pulsemixer --user

# autotiling (split automatico por proporcao do container)
pip3 install autotiling --user

echo ""
echo "==> Done! Next steps:"
echo "    1. Reboot (applies logind power config)"
echo "    2. Open Neovim — plugins install automatically on first launch"
echo "    3. Run: swaymsg reload (applies sway + new bindings)"
echo ""
echo "    New features after reload:"
echo "      \$mod+r          resize mode (arrow=10px, shift+arrow=50px, +/- gaps)"
echo "      \$mod+minus      scratchpad show"
echo "      \$mod+Shift+minus move to scratchpad"
echo "      \$mod+Tab        workspace back_and_forth"
echo "      Alt+Tab         rofi window switcher (all workspaces)"
echo "      \$mod+n          primeiro workspace vazio"
echo "      \$mod+Shift+b    toggle waybar"
echo "      \$mod+Shift+p    clipboard history (cliphist + fzf)"
echo "      \$mod+Shift+d    do-not-disturb toggle (dunst)"
echo "      XF86 keys       volume, brilho, media (funcionam com tela travada)"
echo "      wlsunset        night mode automatico (06:30-18:30)"
