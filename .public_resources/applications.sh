#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::applications'

###############################################################################################
################################## APPLICATION ADDED ##########################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
### --- NVM --------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"
# shellcheck disable=SC1091
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"


###-----------------------------------------------------------------------------------------###
### --- ZSH-COMPLETIONS --------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v brew > /dev/null 2>&1; then
	FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
	autoload -Uz compinit
	compinit
fi


###-----------------------------------------------------------------------------------------###
### --- ZSH-AUTOSUGGESTIONS ----------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v brew >/dev/null 2>&1; then
	HOMEBREW_PREFIX=/usr/local
	# shellcheck disable=SC1091
	[ -s "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && . "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi


###-----------------------------------------------------------------------------------------###
### --- JENV -------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

# Addes this export up top
# eval export PATH="/Users/administrator/.jenv/shims:${PATH}"
export JENV_SHELL=zsh
export JENV_LOADED=1
unset JAVA_HOME
unset JDK_HOME
# shellcheck disable=SC1091
. '/usr/local/Cellar/jenv/0.5.6/libexec/libexec/../completions/jenv.zsh'
# shellcheck disable=SC2218
jenv rehash 2>/dev/null
# shellcheck disable=SC2218
jenv refresh-plugins
jenv() {
	# shellcheck disable=SC3044
	type typeset > /dev/null 2>&1 && typeset command
	command="$1"
	if [ "$#" -gt 0 ]; then
		shift
	fi

	case "$command" in
	enable-plugin|rehash|shell|shell-options)
		# shellcheck disable=SC2046
		eval $(jenv "sh-$command" "$@");;
	*)
		command jenv "$command" "$@";;
	esac
}


###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###













#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################