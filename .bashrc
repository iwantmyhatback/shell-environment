###############################################################################################
######################################### ENVIORNMENT #########################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
### PROMPT --- SETUP -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

export PS1="%B[\$(date '+%I:%M')]%F{green}%n|%3~: %b%f"



###-----------------------------------------------------------------------------------------###
### PATH -----------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

# Function definition
add_path_item() {
	USAGE="Usage: add_path_item [-f] [-b] [-n] [-q] DIR
	-f Force any instance of DIR to the front of the PATH
	-b Force any instance of DIR to the back of the PATH
	-n Nonexistent directories do not return an error status
	-q Quiet mode"

	TO_FRONT=false
	TO_BACK=false
	ERROR_CODE=1
	QUIET_ECHO='echo'

	while [ "$#" -gt 0 ]; do
		case "$1" in
			-f)
				TO_FRONT=true
				shift
				;;
			-b)
				TO_BACK=true
				shift
				;;
			-n)
				ERROR_CODE=0
				shift
				;;
			-q)
				QUIET_ECHO=':'
				shift
				;;
			*)
				break
				;;
		esac
	done

	if [ -z "$1" ]; then
		printf "\n%s\n" "$USAGE" 1>&2
		return 1
	fi

	if [ "${TO_FRONT}" = 'true' ] && [ "${TO_BACK}" = 'true' ]; then
		printf "\n%s\n" "$USAGE" 1>&2;
		return 1
	fi

	if [ ! -d "$1" ]; then
		$QUIET_ECHO "$1 is not a directory." 1>&2
		return $ERROR_CODE
	fi

	NEW_PATH_ITEM="${1}"

	case :${PATH}: in
		*:"$NEW_PATH_ITEM":*)
			if [ ! "${TO_FRONT}" = 'true' ] || [ ! "${TO_BACK}" = 'true' ]; then
				$QUIET_ECHO "${NEW_PATH_ITEM} already in path." 1>&2
				return 0
			fi
			PATH="${PATH#$NEW_PATH_ITEM:}"        # remove if at the start
			PATH="${PATH%:$NEW_PATH_ITEM}"        # remove if at the end
			PATH=$(printf "%s" "$PATH" | sed "s|:$NEW_PATH_ITEM:|:|g")    # remove if in the middle
	esac

	if [ ! "${TO_FRONT}" = 'true' ]; then
		$QUIET_ECHO "moved ${NEW_PATH_ITEM} to front of path." 1>&2
		export PATH="${NEW_PATH_ITEM}:${PATH}"
		return 0
	fi
	if [ ! "${TO_BACK}" = 'true' ]; then
		$QUIET_ECHO "moved ${NEW_PATH_ITEM} to back of path." 1>&2
		export PATH="${PATH}:${NEW_PATH_ITEM}"
		return 0
	fi
}


# Sandard locations
add_path_item -q -b "/bin"
add_path_item -q -b "/sbin"
add_path_item -q -b "/usr/bin"
add_path_item -q -b "/usr/sbin"
add_path_item -q -b "/opt/homebrew/bin"
add_path_item -q -b "/opt/homebrew/sbin"
add_path_item -q -b "/opt/X11/bin"
add_path_item -q -b "/usr/local/bin"
add_path_item -q -b "/usr/local/sbin"
add_path_item -q -b "/usr/local/Cellar"
add_path_item -q -b "/usr/local/share"
add_path_item -q -b "/usr/local/opt/openjdk/bin"
add_path_item -q -f "${HOME}/.jenv/shims"
export PATH=${PATH}



###-----------------------------------------------------------------------------------------###
### LOAD RESOURCES -------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

git -C "${HOME}/.shell-environment" pull
if [ ${?} -eq 0 ];then
	printf '\033[1A'; printf '\033[K'
fi

. "${HOME}/.shell-environment/private_resources/functions.sh"
. "${HOME}/.shell-environment/public_resources/functions.sh"

. "${HOME}/.shell-environment/private_resources/opts.sh"
. "${HOME}/.shell-environment/public_resources/opts.sh"

. "${HOME}/.shell-environment/private_resources/variables.sh"
. "${HOME}/.shell-environment/public_resources/variables.sh"

. "${HOME}/.shell-environment/private_resources/aliases.sh"
. "${HOME}/.shell-environment/public_resources/aliases.sh"

. "${HOME}/.shell-environment/private_resources/applications.sh"
. "${HOME}/.shell-environment/public_resources/applications.sh"



