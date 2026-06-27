# Powerlevel10k instant prompt (must stay at top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups hist_ignore_space share_history

# Autocompletion
autoload -Uz compinit && compinit
setopt complete_aliases
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Environment
export EDITOR=nvim
export TERMINAL=alacritty
export LANG=pt_BR.UTF-8

# eza (modern ls)
alias ls='eza'
alias ll='eza -lah --git'
alias la='eza -a'
alias lt='eza --tree'

# bat (cat with syntax highlighting)
alias cat='bat --paging=never'
alias less='bat'

# Tools
alias n='nvim'
alias vi='nvim'
alias vim='nvim'
alias grep='grep --color=auto'
alias lg='lazygit'
alias ldk='lazydocker'
alias du='dua'
alias fetch='fastfetch'

# fzf — fuzzy finder
source /usr/share/fzf/key-bindings.zsh 2>/dev/null
source /usr/share/fzf/completion.zsh 2>/dev/null
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zoxide (smart cd)
eval "$(zoxide init zsh)"
alias cd='z'

# Powerlevel10k
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# SSH agent via keychain (enter passphrase once per login)
eval "$(keychain --eval --quiet ~/.ssh/id_ed25519)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
