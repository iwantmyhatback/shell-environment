#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::functions'

###############################################################################################
###################################### PUBLIC FUNCTIONS #######################################
###############################################################################################

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
###--- LIST JAVA ---------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

list_java(){
	/usr/libexec/java_home -V
}

###-----------------------------------------------------------------------------------------###
###--- REFRESH JAVA ------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

refresh_java(){
	for JDK in "$(brew --prefix)/opt/openjdk"*;do 
		DEST_JDK="$(basename ${JDK} | sed 's/\@/\-/g').jdk"
		sudo ln -sfn "${JDK}/libexec/openjdk.jdk" "/Library/Java/JavaVirtualMachines/${DEST_JDK}";
	done 
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
###--- UNZIP ALL ---------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

unzip_all() {
	# Leave this alone for the output formatting
	USAGE="Usage: unzip_all SOURCE_DIR [DEST_DIR]
SOURCE_DIR	| REQUIRED |  Location to look for ZIP files
DEST_DIR	| OPTIONAL |  Location to output extracted files.
			      If ommited output will go to \"SOURCE_DIR-unpacked\" in current working directory"

	if [ -d "$1" ]; then
		SOURCE_DIR="${1}"
	else
		printf '%s\n' "${USAGE}"
		return 1
	fi

	if [ -n "$2" ]; then
		DEST_DIR="${2}"
	else
		DEST_DIR="${1}-unpacked"
	fi

	mkdir -p "${DEST_DIR}"
	printf '\n[WORKING]: %s\n' "$(pwd)"
	printf '[SOURCE]: %s\n' "${SOURCE_DIR}"
	printf '[DEST]: %s\n\n' "${DEST_DIR}"

	for FILE in "${SOURCE_DIR}"/*.zip; do
		(
			printf '[UNPACK START] %s\n' "${FILE}"
			unzip -qj "${FILE}" -d "${DEST_DIR}"
			printf '[UNPACK FINISH] %s\n' "${FILE}"
		) &
	done

	printf '[WAIT] Waiting for all threads\n' 
	wait
	printf '[WAIT] Done waiting!\n' 

	printf '[SCRIPT COMPLETE]\n' 
}



###-----------------------------------------------------------------------------------------###
###--- AWAKE (INSOMNIAC) -------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

awake(){
 
	if ! command -v caffeinate > /dev/null 2>&1; then 
		printf '[ERROR] no caffeinate available on this system\n'; 
		return 1
	fi

	HELP="Usage: awake [on|off]"
	ERR="[INVALID ARG]: Must pass exactly 1 arg [on|off]"

	if [ ${#} -ne 1 ] || { [ "${1}" != "on" ] && [ "${1}" != "off" ]; };then
			printf "%s\n\t%s\n" "${HELP}" "${ERR}"
			return 1
	fi

	if [ "${1}" = "on" ] && [ -z "$(pgrep caffeinate)" ];then
			printf "(-‿-)\r"
			sleep .5
			printf "(ಠ_ಠ)\r"
			sleep .3
			# shellcheck disable=SC2091
			$(nohup -- /usr/bin/caffeinate -disu > /dev/null 2>&1 &)
			return 0

	fi

	if [ "${1}" = "off" ] && [ -n "$(pgrep caffeinate)" ];then
			printf "(ಠ_ಠ)\r"
			sleep .5
			printf "(-‿-)\r"
			sleep .3
			kill $(pgrep caffeinate)
			return 0
	fi
}



###-----------------------------------------------------------------------------------------###
###--- PBEXEC ------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###


# Execute whatever is in the paseboard
pbexec(){
	# Add trailing newline & Trim leading/trailing whitespace
	PASTE=$(printf '%s\n' "$(pbpaste)" | awk '{$1=$1};1')
	# Escape special shell characters
	PASTE=$(printf '%s' "${PASTE}" | sed "s/[\\&\`\"'$\|!;*?(){}[\]<>]/\\&/g")
	if [ "${PASTE}" = 'pbexec' ]; then
		printf '[INVALID ARG] Circular call! content == "pbexec"\n' 
		return 1
	fi
	while IFS= read -r LINE; do
		eval ${LINE}; 
	done  << EOF
${PASTE}
EOF
}



#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################


