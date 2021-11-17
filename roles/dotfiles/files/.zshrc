# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH modifications
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

PATH=$PATH:/Users/whegedus/Library/Python/3.9/bin
PATH=$PATH:/usr/local/bin:/usr/local/sbin
export PATH=$PATH:/usr/local/go/bin:~/go/bin

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Fix `ls` colors for Solarized Dark theme
# eval `dircolors $HOME/.dircolors`

# Which plugins would you like to load?
plugins=(git asdf docker)

source $ZSH/oh-my-zsh.sh

# User configuration
source <(kubectl completion zsh)
source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.poetry/bin:$PATH"
export GOPRIVATE=*.liberty.edu

# Source scripts in profile.d
# source /etc/profile.d/*.sh

# Go Version Management
[[ -s "/home/wbhegedus/.gvm/scripts/gvm" ]] && source "/home/wbhegedus/.gvm/scripts/gvm"

# Python Version Management
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# NodeJS Version Management
export N_PREFIX=$HOME
export PATH=$PATH:$HOME/bin

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

eval "$(direnv hook zsh)"

export EDITOR=vim
