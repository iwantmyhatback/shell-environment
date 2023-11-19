#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::opts'

###############################################################################################
####################################### PUBLIC OPTIONS ########################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
###--- SET ---------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if is_bash;then
	shopt -s histappend; HISTCONTROL=erasedups # Causes all previous lines matching the current line to be removed from the history list before that line is saved
	shopt -s histappend; HISTCONTROL=ignorespace # Lines which begin with a space character are not saved in the history list
	# shopt -s histappend; HISTCONTROL=ignoredups # Causes lines which match the previous history entry to not be saved
	# shopt -s histappend; HISTCONTROL=ignoreboth # Is shorthand for ‘ignorespace’ and ‘ignoredups’
elif is_zsh;then
	# If a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event).
	setopt HIST_IGNORE_ALL_DUPS
	# When searching for history entries in the line editor, do not display duplicates of a line previously found, even if the duplicates are not contiguous.
	setopt HIST_FIND_NO_DUPS
	# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. Substitutions within prompts do not affect the command status.
	setopt prompt_subst
	setopt HIST_EXPIRE_DUPS_FIRST
	setopt HIST_IGNORE_DUPS
	setopt HIST_IGNORE_SPACE
	setopt HIST_SAVE_NO_DUPS
elif is_sh;then
	# /bin/sh opts here
	:
else
	printf '[ERROR] Unknown shell type!\n'
	exit 1
fi


###-----------------------------------------------------------------------------------------###
###--- UNSET -------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###


###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###










#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################