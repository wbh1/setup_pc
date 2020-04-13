# PATH modifications
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin:~/go/bin

# Path to your oh-my-zsh installation.
export ZSH="/home/wbhegedus/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status kubecontext)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
source <(kubectl completion zsh)
