#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::applications'

###############################################################################################
################################## APPLICATION ADDED ##########################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
### --- NVM --------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

###-----------------------------------------------------------------------------------------###
### --- ZSH-COMPLETIONS --------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v brew > /dev/null 2>&1; then
	if [ "${SHELL}" = '/bin/zsh' ];then
		FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
		autoload -Uz compinit
		compinit
	fi
fi


###-----------------------------------------------------------------------------------------###
### --- ZSH-AUTOSUGGESTIONS ----------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v brew >/dev/null 2>&1; then
	if [ "${SHELL}" = '/bin/zsh' ];then
		# shellcheck disable=SC1091
		[ -s "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && . "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
	fi
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
. "$(brew --prefix)/Cellar/jenv/0.5.6/libexec/libexec/../completions/jenv.zsh"
# shellcheck disable=SC2218
jenv rehash 2>/dev/null
# shellcheck disable=SC2218
jenv refresh-plugins
jenv() {
	# shellcheck disable=SC3044
	type typeset > /dev/null 2>&1 && typeset command
	command="${1}"
	if [ "$#" -gt 0 ]; then
		shift
	fi

	case "${command}" in
	enable-plugin|rehash|shell|shell-options)
		# shellcheck disable=SC2046
		eval $(jenv "sh-${command}" "$@");;
	*)
		command jenv "${command}" "$@";;
	esac
}


###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

export PYENV_ROOT="$HOME/.pyenv"
[ -d "${PYENV_ROOT}/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###













#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################
