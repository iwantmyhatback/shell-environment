###############################################################################################
######################################### ENVIORNMENT #########################################
###############################################################################################

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


###-----------------------------------------------------------------------------------------###
### LOAD RESOURCES -------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

. .private_resources/opts.sh
. .public_resources/opts.sh

. .private_resources/variables.sh
. .public_resources/variables.sh

. .private_resources/aliases.sh
. .public_resources/aliases.sh

. .private_resources/functions.sh
. .public_resources/functions.sh

. .private_resources/applications.sh
. .public_resources/applications.sh



