# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory extendedglob nomatch notify
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

# command not foud 
# ubuntu
[[ -e /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
# arch
[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# alias
alias ls="ls --color=auto"

# plugin
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=14'
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
