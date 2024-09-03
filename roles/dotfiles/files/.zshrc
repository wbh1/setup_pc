# zmodload zsh/zprof
# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

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


# Set theme
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Fix `ls` colors for Solarized Dark theme
# eval `dircolors $HOME/.dircolors`

# Which plugins would you like to load?
plugins=(git docker golang terraform fzf-zsh-plugin zsh-autosuggestions zsh-syntax-highlighting)

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

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
  # required so that commands from mise show in +commands var
  eval "$(mise hook-env -s zsh)"
fi

if (( $+commands[rye] )); then
  source "$HOME/.rye/env"
fi

#if (( $+commands[op] )); then
#  eval "$(op signin)"
#fi

if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

if (( $+commands[jira] )); then
  eval "$(jira completion zsh)"
fi

if (( $+commands[hss] )); then
  hss_repo=$(dirname $(ls -l ~/.hss.yml | awk '{print $11}'))
  # only update once a day
  if [[ $(date +'%D') -eq $(date -r ${hss_repo}/.git +'%y') ]]; then 
    cd $(dirname $(ls -l ~/.hss.yml | awk '{print $11}')) && git pull -q upstream master
    cd -
  fi
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
# export N_PREFIX=$HOME
# export PATH=$HOME/bin:$PATH

(( $+commands[bashcompinit] )) && bashcompinit

export EDITOR=vim

# Perl garbage
if [ -d "$HOME/perl5" ]; then
  PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
  PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
fi

ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = 'tmux: server' ]; then
    tmux rename-window ${@: -1} # <---- ここ
    command ssh "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command ssh "$@"
  fi
}

hss() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = 'tmux: server' ]; then
    tmux rename-window ${@: -1} # <---- ここ
    command hss "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command hss "$@"
  fi
}

if (( ${+WSL_DISTRO_NAME} )); then
  # Configure ssh forwarding
  export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
  # need `ps -ww` to get non-truncated command for matching
  # use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
  ALREADY_RUNNING=$(ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $?)
  if [[ $ALREADY_RUNNING != "0" ]]; then
      if [[ -S $SSH_AUTH_SOCK ]]; then
          # not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
          echo "removing previous socket..."
          rm $SSH_AUTH_SOCK
      fi
      echo "Starting SSH-Agent relay..."
      # setsid to force new session to keep running
      # set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
      (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
  fi

  export KUBECONFIG="${$(ls ~/.kube/config.d/*)//$'\n'/:}"
fi

export VAULT_ADDR="https://vault.linode.com:8200"
export TZ_LIST="UTC;US/Pacific,West Coast;Asia/Calcutta,India"
source ~/.aliases

eval "$(starship init zsh)"
# zprof
