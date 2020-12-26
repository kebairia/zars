#!/bin/env sh
source ./misc.sh
# misc {{{1
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
setup_color(){
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
# User managmenet {{{1
getuserandpass() { \
	# Prompts user for new username an password.
	read -p "Please enter a name for the user account: " name || exit 1
	while ! echo "$name" | grep -q "^[a-z_][a-z0-9_-]*$"; do
		_error "Username not valid. \nGive a username beginning with a letter, with only lworcase letters, - or_.\n\n"
		read -p "Please enter a name for the user account: " name || exit 1
	done
	printf "Enter a password for ${name}: " && read -s pass1
	printf "\nRetype password: " && read -s pass2
	printf "\n"
	while ! [ "$pass1" = "$pass2" ]; do
		unset pass2
		_error "Passwords do not match.\\n\\nEnter password again.\n"
		printf "Enter a password for ${name}: " && read -s pass1
		printf "\nRetype password: " && read -s pass2
		printf "\n"

	done ;}

adduserandpass() { \
	# Adds user `$name` with password $pass1.
	# TODO: choose zsh by default, otherwise use bash 
	_info "Adding user \"$name\"...\n"
	useradd -m -s /bin/bash "$name" >/dev/null 2>&1 ||
	usermod -a -G wheel "$name" && mkdir -p /home/"$name" && chown "$name":"$name" /home/"$name"
	repodir="/home/$name/.local/src"; mkdir -p "$repodir"; chown -R "$name":"$name" "$(dirname "$repodir")"
	echo "$name:$pass1" | chpasswd

	echo "name: $(grep "${name}" /etc/passwd | awk -F ":" '{print $1}' )" 
	echo "uid: $(grep "${name}" /etc/passwd | awk -F ":" '{print $3}' )" 
	echo "gid: $(grep "${name}" /etc/passwd | awk -F ":" '{print $4}' )" 
	echo "shell: $(grep "${name}" /etc/passwd | awk -F ":" '{print $NF}' )" 
	unset pass1 pass2 ;}

usercheck() { \
	! { id -u "$name" >/dev/null 2>&1; } ||
	dialog --colors --title "WARNING!" --yes-label "CONTINUE" --no-label "No wait..." --yesno "The user \`$name\` already exists on this system. LARBS can install for a user already existing, but it will \\Zboverwrite\\Zn any conflicting settings/dotfiles on the user account.\\n\\nLARBS will \\Zbnot\\Zn overwrite your user files, documents, videos, etc., so don't worry about that, but only click <CONTINUE> if you don't mind your settings being overwritten.\\n\\nNote also that LARBS will change $name's password to the one you just gave." 14 70
	}
#}}}
refreshkeys() { \
	dialog --infobox "Refreshing Arch Keyring..." 4 40
	pacman -Q artix-keyring >/dev/null 2>&1 && pacman --noconfirm -S artix-keyring >/dev/null 2>&1
	pacman --noconfirm -S archlinux-keyring >/dev/null 2>&1
	}
install_pkgs(){
	pacman --noconfirm --needed -S ${1} >/dev/null 2>&1;
}
