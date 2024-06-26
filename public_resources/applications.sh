#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::applications'

###############################################################################################
################################## APPLICATION ADDED ##########################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
### --- NVM --------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v nvm >/dev/null 2>&1; then
	if is_bash; then
		export NVM_DIR="$HOME/.nvm"
		[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
		[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
	fi
fi



###-----------------------------------------------------------------------------------------###
### --- ZSH-COMPLETIONS --------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v brew > /dev/null 2>&1; then
	if is_zsh;then
		FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
		autoload -Uz compinit
		compinit
	fi
fi



###-----------------------------------------------------------------------------------------###
### --- ZSH-AUTOSUGGESTIONS ----------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v brew >/dev/null 2>&1; then
	if is_zsh;then
		# shellcheck disable=SC1091
		[ -s "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && . "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
	fi
fi



###-----------------------------------------------------------------------------------------###
### --- JENV -------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v jenv >/dev/null 2>&1; then
	export JENV_SHELL=zsh
	export JENV_LOADED=1
	unset JAVA_HOME
	unset JDK_HOME
	# shellcheck disable=SC1090
	. "$(brew --prefix)"/Cellar/jenv/*/libexec/completions/jenv.zsh
	# shellcheck disable=SC2218
	jenv rehash 2>/dev/null
	# shellcheck disable=SC2218
	jenv refresh-plugins
	jenv() {
		# shellcheck disable=SC3044
		type typeset > /dev/null 2>&1 && typeset command
		input="${1}"
		if [ "$#" -gt 0 ]; then
			shift
		fi

		case "${input}" in
		enable-plugin|rehash|shell|shell-options)
			# shellcheck disable=SC2046
			eval $(jenv "sh-${input}" "$@");;
		*)
			command jenv "${input}" "$@";;
		esac
	}
fi



###-----------------------------------------------------------------------------------------###
###--- PYENV -------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v pyenv >/dev/null 2>&1; then
	export PYENV_ROOT="$HOME/.pyenv"
	[ -d "${PYENV_ROOT}/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi



###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###




#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################



