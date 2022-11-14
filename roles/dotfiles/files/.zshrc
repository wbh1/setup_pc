# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

uname_output=$(uname)

# # # # # # # # # # # #
# PATH modifications  #
# # # # # # # # # # # #

# prefer local binaries
PATH=/usr/local/bin:/usr/local/sbin:$PATH

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ "$uname_output" = "Darwin" ]; then
  PATH=$PATH:$HOME/Library/Python/3.9/bin
fi

PATH=$PATH:~/go/bin:/usr/local/go/bin

PATH="$HOME/.poetry/bin:$PATH"

export PATH

# # # # # #

# Rust
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

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
# Shell completion
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
fi

if (( $+commands[helm] )); then
  source <(helm completion zsh)
fi

if (( $+commands[flux] )); then
  source <(flux completion zsh)
fi

if (( $+commands[rbenv] )); then
  eval "$(rbenv init - zsh)"
fi

if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source scripts in profile.d
# source /etc/profile.d/*.sh

# Go Version Management
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Python Version Management
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if (( $+commands[pyenv] )); then
  eval "$(pyenv init -)"
fi


# NodeJS Version Management
export N_PREFIX=$HOME
export PATH=$PATH:$HOME/bin

(( $+commands[bashcompinit] )) && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

export EDITOR=vim
