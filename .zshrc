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

# Aliases úteis
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias vi='nvim'
alias vim='nvim'
alias grep='grep --color=auto'

# Variáveis de ambiente
export EDITOR=nvim
export TERMINAL=alacritty
export LANG=pt_BR.UTF-8

# Powerlevel10k
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# Configuração do p10k (gerada pelo wizard)
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
