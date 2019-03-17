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

# Haskell
export PATH=$PATH:~/.cabal/bin/

# Proton
export WINEPREFIX=/home/serathius/.steam/steam/steamapps/common/Proton\ 3.7/dist/share/default_pfx
export WINEPATH=/home/serathius/.steam/steam/steamapps/common/Proton\ 3.7/dist/bin/wine64

# Golang
[[ -s "/home/serathius/.gvm/scripts/gvm" ]] && source "/home/serathius/.gvm/scripts/gvm"
export GOPATH=/home/serathius/Projects/go
export PATH=$PATH:$GOPATH/bin/

# Python
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=/home/serathius/.venvs
[[ -f /home/serathius/.local/bin/virtualenvwrapper.sh ]] && source /home/serathius/.local/bin/virtualenvwrapper.sh
