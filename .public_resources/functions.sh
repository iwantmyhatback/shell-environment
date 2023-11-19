#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::functions'

###############################################################################################
###################################### PUBLIC FUNCTIONS ############*##########################
###############################################################################################

###-----------------------------------------------------------------------------------------###
###--- PATH --------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

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


###-----------------------------------------------------------------------------------------###
###--- REMOTE COPY -------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

remote_copy(){
	# -r recursive
	# -l links Copy symlinks as symlinks
	# -c Update: Use checksums to compare file differences and only write if there is a difference..
	# -t Preserve timestamps (helps with update)
	# -h Use human readable numbers (for file sizes etc, used for progress)
	# -p Preserve permissions (such as wrx).  Doesn't conflict with different users/groups.
	# -E copy extended attributes.  (this is important for .dmg files that have the com.apple.macl bit)
	# -—progress use a progress meter
	# -—exclude=<BRE PATTERN>
	rsync -rltpchE "${1}" "${2}"
}


###-----------------------------------------------------------------------------------------###
###--- SET JAVA ----------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

set_java(){
	if [ -z ${1+x} ];then
		echo "[ERROR] Pass a valid version (ie: 11 or 17)"
		return 1
	fi
	JAVA_HOME="$(/usr/libexec/java_home -v ${1})"
	export JAVA_HOME
}


###-----------------------------------------------------------------------------------------###
###--- File Exists -------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

file_exists() {
	(
		while [ "$#" -gt 0 ]; do
			case "$1" in
				-h)
					printf "Usage: file_exists [-v] PATH\n  -v | Outputs [Found|Not Found] to the console\n  -h | Displays this message\n"
					return 1
					;;
				-v)
					VERBOSE=true
					shift
					;;
				*)
					break
					;;
			esac
		done

		OBJECT=${1:?"File path must be specified"}

		if [ -f "${OBJECT}" ] || [ -L "${OBJECT}" ] || [ -d "${OBJECT}" ]; then
			[ "${VERBOSE}" = "true" ] && printf "Found\n"
			return 0
		fi
		[ "${VERBOSE}" = "true" ] && printf "Not Found\n"
		return 1
	)
}


###-----------------------------------------------------------------------------------------###
###--- Is Mac Machine ----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

is_mac(){
	if test "$(uname)" = "Darwin"; then
		return 0
	else
		return 1
	fi
}


###-----------------------------------------------------------------------------------------###
###--- Is Zshell ---------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

is_zsh(){
	if test "${ZSH_NAME-}"; then
		return 0
	else
		return 1
	fi
}


###-----------------------------------------------------------------------------------------###
###--- Is Bash -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

is_bash(){
	if test "${BASH-}"; then
		return 0
	else
		return 1
	fi
}


###-----------------------------------------------------------------------------------------###
###--- Is sh--------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

is_sh(){
	if test "${POSIXLY_CORRECT-}"; then
		return 0
	else
		return 1
	fi
}


###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###










#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################