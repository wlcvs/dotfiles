# dotfiles

Configuração pessoal para **Fedora 44 Sway** em ThinkPad.

## Stack

| Função | Ferramenta |
|---|---|
| Compositor | Sway |
| Terminal | Alacritty |
| Multiplexador | tmux |
| Shell | zsh + Powerlevel10k |
| Editor | Neovim |
| Launcher | Rofi |
| Barra | Waybar |
| Notificações | Dunst |
| Screenshots | Grimshot (grim + slurp) |
| Áudio | PipeWire |
| Tema | Catppuccin Mocha |

## Instalação

```bash
git clone https://github.com/wlcsv/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

Após instalar, rode `p10k configure` no terminal para personalizar o prompt.

## Atalhos — Sway

| Atalho | Ação |
|---|---|
| `Super+Enter` | Abre Alacritty (com tmux) |
| `Super+D` | Launcher (Rofi) |
| `Super+Shift+Q` | Fecha janela |
| `Super+Shift+E` | Sair do Sway |
| `Super+Shift+C` | Recarrega config |
| `Super+F` | Fullscreen |
| `Super+Shift+Space` | Alterna flutuante |
| `Super+1..0` | Troca workspace |
| `Super+Shift+1..0` | Move janela para workspace |
| `Super+H/J/K/L` | Foco (estilo vim) |
| `Super+Shift+H/J/K/L` | Move janela |
| `Super+B` | Split horizontal |
| `Super+V` | Split vertical |
| `Super+R` | Modo resize |
| `Super+Minus` | Scratchpad |

## Atalhos — Screenshots

| Atalho | Ação |
|---|---|
| `Print` | Tela inteira → salva em `~/Imagens` |
| `Alt+Print` | Janela ativa → salva em `~/Imagens` |
| `Ctrl+Print` | Seleciona área → salva em `~/Imagens` |
| `Shift+Print` | Seleciona área → copia para clipboard |

## Atalhos — tmux

Prefix: `Ctrl+A`

| Atalho | Ação |
|---|---|
| `Prefix + \|` | Split vertical |
| `Prefix + -` | Split horizontal |
| `Prefix + C` | Nova janela |
| `Alt+Seta` | Navegar entre painéis |
| `Prefix + R` | Recarregar config |

## Teclado

- Layout: **Português Brasil (ThinkPad ABNT2)**
- `Caps Lock` → `Esc`
- `Esc` → `Caps Lock`
