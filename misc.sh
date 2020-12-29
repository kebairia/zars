#!/bin/env sh
#                            
#┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#┃ ╻ ╻┏━┓╻  ┏━┓┏━┓┏┳┓┏━┓  ━┳━┏━┓  ╺━┓┏━┓┏━┓┏━┓ ┃
#┃ ┃╻┃┣━ ┃  ┃  ┃ ┃┃╹┃┣━    ┃ ┃ ┃  ┏━┛┣━┫┣┳┛┗━┓ ┃
#┃ ┗┻┛┗━┛┗━┛┗━┛┗━┛╹ ╹┗━┛   ╹ ┗━┛  ┗━╸╹ ╹╹┗╸┗━┛ ┃
#┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
#
set -e 
_error(){
	printf ${RED}"Error:${RESET} $@" >&2
}
_info(){
	printf ${YELLOW}"INFO:${RESET} $@"
}
_done(){
	echo ${GREEN}" DONE"${RESET}
}
_underline() {
  echo "$(printf '\033[4m')$@$(printf '\033[24m')"
}

_code() {
  echo "\`$(printf '\033[38;5;247m')$@${RESET}\`"
}
_loading() {
  echo -n "$(printf '\033[38;5')$@${RESET}"
}
command_exists(){
    command -v "$@" >/dev/null 2>&1
}
function setup_color(){
	# Only use color if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[0;31m')
		GREEN=$(printf '\033[0;32m')
		YELLOW=$(printf '\033[0;33m')
		BLUE=$(printf '\033[0;34m')
		PURPLE=$(printf '\033[0;35m')
		CYAN=$(printf '\033[0;36m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[0m')
	else
		RED=''
		GREEN=''
		YELLOW=''
		BLUE=''
		PURPLE=''
		CYAN=''
		BOLD=''
		RESET=''
	fi
}
#}}}
function banner(){
	echo "	┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
	echo "	┃ [0;1;31;91m╻ [0;1;35;95m╻┏[0;1;33;93m━┓[0;1;32;92m╻ [0;1;36;96m ┏[0;1;35;95m━┓[0;1;34;94m┏━[0;1;31;91m┓┏[0;1;32;92m┳┓[0;1;33;93m┏━[0;1;36;96m┓  ━[0;1;33;93m┳━┏[0;1;34;94m━┓  [0;1;32;92m╺━[0;1;31;91m┓┏[0;1;35;95m━┓[0;1;33;93m┏[0;1;34;94m━┓[0;1;36;96m┏━[0;1;31;91m┓[0m ┃"

	echo "	┃ [0;1;32;92m┃╻[0;1;33;93m┃┣━[0;1;31;91m ┃ [0;1;34;94m ┃ [0;1;36;96m ┃[0;1;31;91m ┃┃[0;1;35;95m╹┃[0;1;32;92m┣━ [0;1;33;93m  [0;1;35;95m ┃[0;1;32;92m ┃[0;1;33;93m ┃[0;1;35;95m  [0;1;31;91m┏━[0;1;34;94m┛[0;1;36;96m┣[0;1;33;93m━[0;1;31;91m┫┣[0;1;32;92m┳[0;1;33;93m┛┗[0;1;36;96m━[0;1;34;94m┓[0m ┃"

	echo "	┃ [0;1;33;93m┗┻[0;1;35;95m┛┗[0;1;31;91m━┛[0;1;32;92m┗━[0;1;34;94m┛┗[0;1;31;91m━┛[0;1;37;97m┗[0;1;33;93m━┛[0;1;35;95m╹ ╹[0;1;32;92m┗━[0;1;34;94m┛  [0;1;36;96m ╹ [0;1;33;93m┗━[0;1;35;95m┛[0;1;32;92m  ┗[0;1;34;94m━╸[0;1;36;96m╹ [0;1;33;93m╹╹[0;1;31;91m┗╸[0;1;32;92m┗━[0;1;31;91m┛[0m ┃"
	echo "	┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
}

function usage() {
    echo "Usage: $0 [options] [arguments]"
    echo
    echo "Options"
    echo "  -l   something"
    echo "  -l   something"
    echo "  -l   something"
    exit 1
}
setup_color
