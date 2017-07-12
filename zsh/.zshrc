# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/till/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# completion options
#setopt menucomplete 
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#color
autoload -U colors 
colors

# prompt
autoload -Uz promptinit
promptinit
PROMPT='%F{blue}%1~%f %f➜%f '
RPROMPT='[%F{yellow}%?%f]'

# alias
alias ls="ls --color=auto"

# plugin
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=14'
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
