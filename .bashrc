###############################################################################################
######################################### ENVIORNMENT #########################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
### LOAD RESOURCES -------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

git -C "${HOME}/.shell-environment" pull
if [ ${?} -eq 0 ];then
	printf '\033[1A'; printf '\033[K'
fi

. "${HOME}/.shell-environment/.private_resources/functions.sh"
. "${HOME}/.shell-environment/.public_resources/functions.sh"

. "${HOME}/.shell-environment/.private_resources/opts.sh"
. "${HOME}/.shell-environment/.public_resources/opts.sh"

. "${HOME}/.shell-environment/.private_resources/variables.sh"
. "${HOME}/.shell-environment/.public_resources/variables.sh"

. "${HOME}/.shell-environment/.private_resources/aliases.sh"
. "${HOME}/.shell-environment/.public_resources/aliases.sh"

. "${HOME}/.shell-environment/.private_resources/applications.sh"
. "${HOME}/.shell-environment/.public_resources/applications.sh"


###-----------------------------------------------------------------------------------------###
### PATH -----------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

# Sandard locations
add_path_item -q -b "/bin"
add_path_item -q -b "/sbin"
add_path_item -q -b "/usr/bin"
add_path_item -q -b "/usr/sbin"
add_path_item -q -b "/usr/local/bin"
add_path_item -q -b "/usr/local/sbin"export PS1="%B[%kT]%F{green}%n|%3~: %b%f"
add_path_item -q -b "/usr/local/Cellar"
add_path_item -q -b "/usr/local/share"
add_path_item -q -b "/usr/local/opt/openjdk/bin"
add_path_item -q -f "${HOME}/.jenv/shims"
export PATH=${PATH}


###-----------------------------------------------------------------------------------------###
### PROMPT --- SETUP -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

export PS1="%B[\$(date '+%I:%M')]%F{green}%n|%3~: %b%f"
