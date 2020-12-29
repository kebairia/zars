#!/bin/env sh
source ./misc.sh
PACKAGES_FILE="./packages.cvs"
# setup_config {{{1
setup_config(){
    if ! command_exists git; then
        _error "Git is not installed.\n"
        _info "Installing..." \
            && pacman --noconfirm -S git &>/dev/null \
            && _done
    fi

    read -p "Enter GIT repo: " GIT_REPO
    read -p "where you want to install your local repo?: " DOT_DIR
    if [ ! -d "${DOT_DIR}" ];then
    	git clone --bare "${GIT_REPO}" "/home/${name}/${DOT_DIR}" 
    else
    	_error "Repo exist or there's a folder with the same name\n"
    	#read -p "[d]elete old folder,choose [a]nother name, [s]kip, [c]ancel:" choise
    	read -p "[d]elete, [n]ew, [s]kip, [c]ancel:" choise
    	case "$choise" in
    		d) rm -rf ${DOT_DIR} \
    			&& git clone --bare "${GIT_REPO}" "/home/${name}/${DOT_DIR}" 
    					;;
    		n) read -p "Enter local repo's name: " DOT_DIR \
    			&& git clone --bare "${GIT_REPO}" "/home/${name}/${DOT_DIR}" 
    					;;
    		s) echo "Skipped..." ;;
    		c) exit 1 ;;
    	esac
    fi
    _info "installing your config files..."
    /usr/bin/git \
        --git-dir=/home/${name}/${DOT_DIR}/ \
        --work-tree=/home/${name} checkout -f  \
        && _done

    echo "#Generated by zars" >> /home/${name}/.config/misc/aliases
    echo -e "alias config='/usr/bin/git --git-dir=/home/${name}/${DOT_DIR}/ --work-tree=/home/${name}'" \
        >> /home/${name}/.config/misc/aliases
    echo -e "# Generated by zars " >> /home/${name}/.config/git/ignore
    echo -e "/home/${name}/${DOT_DIR}" >> /home/${name}/.config/git/ignore

}
#}}}
# setup_user {{{1
user_exists(){
    grep "^${1}" /etc/passwd >/dev/null 2>&1 

}
getuserandpass() { \
	# Prompts user for new username an password.
	read -p "Please enter a name for the user account: " name || exit 1
    while user_exists "${name}";do
        _error "User \"${name}\" exist, Try another name\n"
	    read -p "Please enter a name for the user account: " name || exit 1
    done
	while ! echo "$name" | grep -q "^[a-z_][a-z0-9_-]*$"; do
		_error "Username not valid. \n"
        _info "Give a username beginning with a letter, with only lworcase letters, - or_.\n\n"
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
    useradd \
        -m \
        -s /bin/bash "$name" \
        >/dev/null 2>&1
	usermod \
        -aG wheel "$name" \
        && mkdir -p /home/"$name" \
        && chown "$name":"$name" /home/"$name"
	repodir="/home/$name/.local/src"; mkdir -p "$repodir"; chown -R "$name":"$name" "$(dirname "$repodir")"
	echo "$name:$pass1" | chpasswd

	echo "name: $(grep "${name}" /etc/passwd | awk -F ":" '{print $1}' )" 
	echo "uid: $(grep "${name}" /etc/passwd | awk -F ":" '{print $3}' )" 
	echo "gid: $(grep "${name}" /etc/passwd | awk -F ":" '{print $4}' )" 
	echo "shell: $(grep "${name}" /etc/passwd | awk -F ":" '{print $NF}' )" 
	unset pass1 pass2 ;}

#}}}
main(){
    banner
    #while getopts ":pch" Option
    #do
        #case $Option in
            #p) install_pkgs ;;
            #c) setup_config ;; 
            #h) usage ;;
            #*) usage ;;
        #esac
    #done
    #install_pkgs
    getuserandpass
    adduserandpass
    setup_config
    setup_packages
}
main
