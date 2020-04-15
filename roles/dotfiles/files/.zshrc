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

PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin:~/go/bin

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Fix `ls` colors for Solarized Dark theme
eval `dircolors $HOME/.dircolors`

# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
source <(kubectl completion zsh)
source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
