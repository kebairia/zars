#!/bin/env sh
set -e 
_error(){
	echo ${RED}"Error: $@"${RESET} >&2
}
_info(){
	printf ${YELLOW}"INFO: $@"${RESET}
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
setup_color(){
	# Only use color if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=''
		GREEN=''
		YELLOW=''
		BLUE=''
		BOLD=''
		RESET=''
	fi
}
install_pkgs(){
	reg_pkgs="$(egrep -v "^#|^A|^G" packages.cvs \
		| awk -F ',' '{print $2}' \
		| tr -s '\n' ' ')"
	pacman -Sw ${reg_pkgs}
}
build_from_src(){
	_info "Building ${1}..."
	sudo make install clean &>/dev/null
	_done
}
copy_config(){
	_info "Copying config files"
	mkdir /home/${name}/.config
	cp -rv config/* /home/${name}/.config
}
install_pkgs 
