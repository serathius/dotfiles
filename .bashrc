# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Bash
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=10000
export HISTIGNORE="ls:ps:history"
shopt -s cmdhist
PROMPT_COMMAND='history -a'
shopt -s checkwinsize
source ~/.bash_aliases
source ~/.prompt
source ~/.gerrit_bash_commands.sh
source ~/.bash_env.sh
source /usr/share/undistract-me/long-running.bash

notify_when_long_running_commands_finish_install
export PATH=$PATH:~/.local/bin

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Haskell
export PATH=$PATH:~/.cabal/bin/

# Proton
export WINEPREFIX=/home/serathius/.steam/steam/steamapps/common/Proton\ 3.7/dist/share/default_pfx
export WINEPATH=/home/serathius/.steam/steam/steamapps/common/Proton\ 3.7/dist/bin/wine64

# Golang
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin/

# Python
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/.venvs
[[ -f $HOME/.local/bin/virtualenvwrapper.sh ]] && source $HOME/.local/bin/virtualenvwrapper.sh
