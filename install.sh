#!/usr/bin/env sh

###############################################################################################
##################################### INSTALL ENVIRONMENT #####################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
###--- ARGUMENT HANDLING -------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

QUIET_ECHO='printf %s\n '
USAGE="Usage: add_path_item [-f] [-d] [-q]
	-f Force the install and overwrite current environment files
	-d Dry run
	-q Quiet mode"

while [ "$#" -gt 0 ]; do
	case "$1" in
		-f)
			FORCE_ACTIVE=true
			shift
			;;
		-d)
			DRY_RUN_ACTIVE=true
			shift
			;;
		-q)
			QUIET_ECHO=':'
			shift
			;;
		*)
			printf "%s\n" "$USAGE" 1>&2
			exit
			break
			;;
	esac
done


###-----------------------------------------------------------------------------------------###
###--- BACKUP CURRENT ENVIRONMENT ----------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

ENVIRONMENT_LOCATION="${HOME}/.shell-environment"
ENVIRONMENT_BACKUP_LOCATION="${ENVIRONMENT_LOCATION}-backup"

if [ -e "${ENVIRONMENT_BACKUP_LOCATION}" ] && [ -z "${FORCE_ACTIVE+x}" ];then
	printf '%s\n' "[ERROR] The environment may have already been installed ... ${ENVIRONMENT_BACKUP_LOCATION} already exists"
	exit 1
fi

ZSH_FILES=".zshrc .zprofile .zlogin .zsh_aliases .zsh_functions .zshenv"
BASH_FILES=".bashrc .bash_profile .bash_login .bash_aliases"
SH_FILES=".profile"
SHELL_FILES="${ZSH_FILES} ${BASH_FILES} ${SH_FILES}"

# Iterate over the list
for SHELL_FILE in $SHELL_FILES; do
	SHELL_FILE="${HOME}/${SHELL_FILE}"

	if [ -e "${SHELL_FILE}" ]; then
		$QUIET_ECHO "${SHELL_FILE} Exists"

		if [ ! -e "${ENVIRONMENT_BACKUP_LOCATION}" ]; then
			mkdir -p "${ENVIRONMENT_BACKUP_LOCATION}"
		fi

		if [ -n "$DRY_RUN_ACTIVE" ]; then
			printf "[INFO] Dry Run Active"

		else
			mv "${SHELL_FILE}" "${ENVIRONMENT_BACKUP_LOCATION}/"
		fi
	fi

done


###-----------------------------------------------------------------------------------------###
###--- MOVE ENVIRONMENT INTO POSITION ------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

PATH_CHECK="readlink -f "
if ! command -v "$PATH_CHECK" > /dev/null 2>&1; then
    PATH_CHECK="realpath"
fi

SCRIPT_LOCATION="$(${PATH_CHECK} ${0})"
SCRIPT_DIR="$(dirname ${SCRIPT_LOCATION})"
GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

$QUIET_ECHO "Script location: ${SCRIPT_LOCATION}"
$QUIET_ECHO "Script directory: ${SCRIPT_DIR}"
$QUIET_ECHO "Git Root directory: ${GIT_ROOT}"

if [ "${SCRIPT_DIR}" != "${GIT_ROOT}" ];then
	printf '%s\n' "[ERROR] It seems the install.sh script (currently running) has been moved"
	exit
fi


SOURCE_SCRIPT="[ -e \"${ENVIRONMENT_LOCATION}/.bashrc\" ] && . \"${ENVIRONMENT_LOCATION}/.bashrc\" "

if [ -n "$DRY_RUN_ACTIVE" ]; then
    printf "[INFO] Dry Run Active"
		printf "To .bashrc : %s\n" "${SOURCE_SCRIPT}"
		printf "To .zshrc : %s\n\n" "${SOURCE_SCRIPT}"
		printf "To .profile : %s\n\n" "${SOURCE_SCRIPT}"
		printf "mv \"%s\" \"%s/.shell-environment\"\n" "${SCRIPT_DIR}" "${HOME}"
else
		printf "%s\n\n" "${SOURCE_SCRIPT}" > "${HOME}/.bashrc"
		printf "%s\n\n" "${SOURCE_SCRIPT}" > "${HOME}/.zshrc"
		printf "%s\n\n" "${SOURCE_SCRIPT}" > "${HOME}/.profile"
		mv "${SCRIPT_DIR}" "${ENVIRONMENT_LOCATION}"
fi


