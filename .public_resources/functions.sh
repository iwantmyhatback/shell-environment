#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::functions'

###############################################################################################
###################################### PUBLIC FUNCTIONS ############*##########################
###############################################################################################

###-----------------------------------------------------------------------------------------###
###--- PATH --------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

add_path_item() {
	usage="Usage: add_path_item [-f] [-b] [-n] [-q] DIR
	-f Force any instance of DIR to the front of the PATH
	-b Force any instance of DIR to the back of the PATH
	-n Nonexistent directories do not return an error status
	-q Quiet mode"

	to_front=false
	to_back=false
	err_code=1
	quiet_echo='echo'

	while [ "$#" -gt 0 ]; do
		case "$1" in
			-f)
				to_front=true
				shift
				;;
			-b)
				to_back=true
				shift
				;;
			-n)
				err_code=0
				shift
				;;
			-q)
				quiet_echo=':'
				shift
				;;
			*)
				break
				;;
		esac
	done

	if [ -z "$1" ]; then
		printf "\n%s\n" "$usage" 1>&2
		return 1
	fi

	if [ "${to_front}" = 'true' ] && [ "${to_back}" = 'true' ]; then
		printf "\n%s\n" "$usage" 1>&2;
		return 1
	fi

	if [ ! -d "$1" ]; then
		$quiet_echo "$1 is not a directory." 1>&2
		return $err_code
	fi

	dir="${1}"

	case :${PATH}: in
		*:"$dir":*)
			if [ ! "${to_front}" = 'true' ] || [ ! "${to_back}" = 'true' ]; then
				$quiet_echo "${dir} already in path." 1>&2
				return 0
			fi
			PATH="${PATH#$dir:}"        # remove if at the start
			PATH="${PATH%:$dir}"        # remove if at the end
			PATH="${PATH//:$dir:/:}"    # remove if in the middle
	esac

	if [ ! "${to_front}" = 'true' ]; then
		$quiet_echo "moved ${dir} to front of path." 1>&2
		export PATH="${dir}:${PATH}"
		return 0
	fi
	if [ ! "${to_back}" = 'true' ]; then
		$quiet_echo "moved ${dir} to back of path." 1>&2
		export PATH="${PATH}:${dir}"
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
					verbose=true
					shift
					;;
				*)
					break
					;;
			esac
		done

		object=${1:?"File path must be specified"}

		if [ -f "$object" ] || [ -L "$object" ] || [ -d "$object" ]; then
			[ "${verbose}" = "true" ] && printf "Found\n"
			return 0
		fi
		[ "${verbose}" = "true" ] && printf "Not Found\n"
		return 1
	)
}


###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###










#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################