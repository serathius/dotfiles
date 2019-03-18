# Author: Marek Siarkowicz

ENV_DIRECTORY="${HOME}/.env"
ENV_NAME_PATTERN='^[a-zA-Z0-9\-]+(/[a-zA-Z0-9\-]+)*$'
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"

# TODO env-copy
# TODO env-create suggestions for directory
# TODO env for directory adds following slash

function env-workon {
  _validate_args_env $1 || return 1
  _validate_env_pattern $1 || return 2
  _validate_env_exists $1 || (env-list && return 3)
  if [ "$CURRENT_ENV" != "" ] ; then
    env-deactivate
  fi
  _ENV_OLD_PS1="$PS1"
  _source_env $1
  CURRENT_ENV="$1"
  PS1="[${GREEN}$1${RESET}]$PS1"
}

function env-deactivate {
  if [ "$CURRENT_ENV" = "" ]
  then
      echo "No env activated"
  fi
  PS1="${_ENV_OLD_PS1}"
  unset CURRENT_ENV
}

function env-list {
  _list_envs | sort | while read f; do echo " - ${f}"; done
}

function env-create {
  _validate_args_env $1 || return 1
  _validate_env_pattern $1 || return 2
  if [ -f "${ENV_DIRECTORY}/$1.env" ] ; then
    echo "Env already exist"
    return 3
  fi
  mkdir -p "$(dirname ${ENV_DIRECTORY}/$1.env)"
  touch "${ENV_DIRECTORY}/$1.env"
  env-edit $1
  env-workon $1
}

function env-edit {
  _validate_args_env $1 || return 1
  _validate_env_pattern $1 || return 2
  _validate_env_exists $1 || (env-list && return 3)
  vi "${ENV_DIRECTORY}/$1.env"
}


function env-delete {
  _validate_args_env $1 || return 1
  _validate_env_pattern $1 || return 2
  _validate_env_exists $1 || (env-list && return 3)
  rm "${ENV_DIRECTORY}/$1.env"
}

_complete_env() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts=$(_list_envs | sed 'N;s/\n/ /;')

  if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
      COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
      return 0
  fi
}

_validate_args_env() {
  if [[ $# -ne 1 ]] || [[ $1 = "" ]] ; then
      echo "Usage: env-workon env"
      return 1
  fi
}

_validate_env_pattern() {
  if ! [[ $1 =~ ${ENV_NAME_PATTERN} ]] ; then
    echo "Incorrect environment name, environment name should match '${ENV_NAME_PATTERN}'"
    return 1
  fi
}

_validate_env_exists() {
  if [ ! -f "${ENV_DIRECTORY}/$1.env" ] ; then
    echo "Unknown env. Available envs:"
    return 2
  fi
}

_list_envs() {
  find "${ENV_DIRECTORY}" -type f -name '*.env' | while read f; do RELATIVE_PATH="${f#${ENV_DIRECTORY}/}";echo ${RELATIVE_PATH%.env}; done
}

_source_env() {
  local _PATH=$1
  local _ARRAY=()
  while [[ $_PATH != "." ]] ; do
    _ARRAY+=("${ENV_DIRECTORY}/${_PATH}.env")
    _PATH=$(dirname $_PATH)
  done
  for (( idx=${#_ARRAY[@]}-1 ; idx>=0 ; idx-- )) ; do
    source "${_ARRAY[idx]}" 2>/dev/null
  done
}

complete -F _complete_env env-edit
complete -F _complete_env env-workon
complete -F _complete_env env-delete

