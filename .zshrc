# Powerlevel10k instant prompt (deve ficar no topo)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Histórico
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups hist_ignore_space share_history

# Autocompletion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
compdef _files ls ll la lt

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Variáveis de ambiente
export EDITOR=nvim
export TERMINAL=alacritty
export LANG=pt_BR.UTF-8

# eza (ls moderno)
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -a --icons'
alias lt='eza --tree --icons'

# bat (cat com syntax highlighting)
alias cat='bat --paging=never'
alias less='bat'

# ferramentas
alias n='nvim'
alias vi='nvim'
alias vim='nvim'
alias grep='grep --color=auto'
alias lg='lazygit'
alias ldk='lazydocker'
alias du='dua'
alias fetch='fastfetch'

# fzf - fuzzy finder
source /usr/share/fzf/shell/key-bindings.zsh 2>/dev/null
source /usr/share/fzf/shell/completion.zsh 2>/dev/null
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zoxide (cd inteligente)
eval "$(zoxide init zsh)"
alias cd='z'

# Powerlevel10k
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# Configuração do p10k (gerada pelo wizard)
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
