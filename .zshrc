# Set colors
#autoload -U colors && colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Set History Size
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Autosuggest settings
ZSH_AUTOSUGGEST_STRATEGY=completion

# Add completion
#source ~/.plugins/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Aliases

alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias cl='clear && pfetch'
alias gimme='fm6000'

# Autorun scripts
pfetch
export PATH=$PATH:~/.emacs.d/bin/

# Plugins

source ~/.config/zsh/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle command-not-found

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

eval "$(starship init zsh)"
